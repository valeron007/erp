class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy, :upload_image, :crop_image]
  after_action :verify_authorized

  # GET /employees
  # GET /employees.json
  def index
    authorize Employee

    @filterrific = initialize_filterrific(
        Employee,
        params[:filterrific],
        select_options: {
            with_position_id: Position.options_for_select,
            with_employee_status_id: EmployeeStatus.options_for_select
        }
    ) or return

    @selected_per_page = get_session_per_page(Employee.per_page)
    if @filterrific.with_employee_status_id.nil?
      @employees = @filterrific.find.active.page(params[:page]).per_page(@selected_per_page)
    else
      @employees = @filterrific.find.page(params[:page]).per_page(@selected_per_page)
    end

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end

  def search
    authorize Employee
    @employees = Employee.search_query(params[:q]).joins(:employee_status).select("employees.id, employees.last_name, employees.first_name, employees.middle_name, employees.employee_status_id")
    # also add the total count to enable infinite scrolling
    employees_count = Employee.search_query(params[:q]).count

    respond_to do |format|
      format.json { render json: {total: employees_count, resources: @employees.map { |e| {id: e.to_option, text: e.to_option, is_active: e.is_active?} }} }
    end
  end

  def export
    authorize Employee

    @employees = Employee.all

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="employees_export.xlsx"'
      }
    end

  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    authorize @employee
    @employee_note = EmployeeNote.new(employee: @employee)
    set_return_to
    @return_to = get_return_to_or_default employees_url

    @additional_list = Array.new
    @material_list = Array.new
    @other_list = Array.new
    @tool_list = Array.new

    income_transactions = STransaction.in_employee(@employee).to_a

    income_transactions.each { |transaction|

      transaction.s_transaction_additionals.each { |additional|
        idx = @additional_list.find_index {|obj| obj.s_additional.id == additional.s_additional.id}
        if idx.blank?
          @additional_list << additional
        else
          @additional_list[idx].s_amount += additional.s_amount
        end
      }

      transaction.s_transaction_materials.each { |material|
        idx = @material_list.find_index {|obj| obj.s_material.id == material.s_material.id}
        if idx.blank?
          @material_list << material
        else
          @material_list[idx].s_amount += material.s_amount
        end
      }

      transaction.s_transaction_others.each { |other|
        idx = @other_list.find_index {|obj| obj.s_other.id == other.s_other.id}
        if idx.blank?
          @other_list << other
        else
          @other_list[idx].s_amount += other.s_amount
        end
      }

      transaction.s_transaction_tools.each { |tool|
        @tool_list << tool
      }

    }

    outcome_transactions = STransaction.out_employee(@employee).to_a

    outcome_transactions.each { |transaction|

      transaction.s_transaction_additionals.each { |additional|
        idx = @additional_list.find_index {|obj| obj.s_additional.id == additional.s_additional.id}
        unless idx.blank?
          @additional_list[idx].s_amount -= additional.s_amount
        end
      }

      transaction.s_transaction_materials.each { |material|
        idx = @material_list.find_index {|obj| obj.s_material.id == material.s_material.id}
        unless idx.blank?
          @material_list[idx].s_amount -= material.s_amount
        end
      }

      transaction.s_transaction_others.each { |other|
        idx = @other_list.find_index {|obj| obj.s_other.id == other.s_other.id}
        unless idx.blank?
          @other_list[idx].s_amount -= other.s_amount
        end
      }

      transaction.s_transaction_tools.each { |tool|
        idx = @tool_list.find_index {|obj| obj.s_tool.id == tool.s_tool.id}
        unless idx.blank?
          @tool_list.delete_at(idx)
        end
      }

    }

    @additional_list = @additional_list.reject {|o| o.s_amount == 0}
    @material_list = @material_list.reject {|o| o.s_amount == 0}
    @other_list = @other_list.reject {|o| o.s_amount == 0}

  end

  # GET /employees/new
  def new
    @employee = Employee.new
    authorize @employee
    @position = Position.new
    set_return_to
    @return_to = get_return_to_or_default employees_url
  end

  # GET /employees/1/edit
  def edit
    authorize @employee
    @position = Position.new
    set_return_to
    @return_to = get_return_to_or_default employees_url
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    @employee.user = current_user
    @position = Position.new
    authorize @employee

    respond_to do |format|
      if @employee.save
        format.html { redirect_back_or_default employees_url, t('Record has been saved') }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    authorize @employee
    @employee.user = current_user
    @position = Position.new
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_back_or_default employees_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    authorize @employee
    set_return_to
    @employee.destroy
    respond_to do |format|
      format.html { redirect_back_or_default leads_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  def upload_image
    authorize @employee
    @employee.user = current_user
    respond_to do |format|
      if @employee.update(employee_params)
        format.js
      end
    end
  end

  def crop_image
    authorize @employee
    @employee.user = current_user
    respond_to do |format|
      if @employee.update(employee_params)
        format.js
      end
    end
  end

  #POST
  def create_note
    @employee_note = EmployeeNote.new(employee_note_params)
    @employee_note.user = current_user
    @employee = @employee_note.employee
    authorize @employee

    respond_to do |format|
      if @employee_note.save
        format.html { redirect_to @employee, notice: t('Note added') }
        format.json { render :show, status: :created, location: @employee_note.employee }
      else
        format.html { render :show }
        format.json { render json: @employee_note.errors, status: :unprocessable_entity }
      end
    end
  end

  #POST
  def destroy_note
    @employee_note = EmployeeNote.find_by_id(params[:id])
    @employee = @employee_note.employee
    authorize @employee
    @employee_note.destroy
    respond_to do |format|
      format.html { redirect_to @employee, notice: t('Note removed') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find_by_id(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :middle_name, :position_id, :hire_date, :probation_period, :employee_status_id, :fire_date, :fire_reason_id, :passport, :birth_date, :citizenship, :nationality, :felony, :felony_notes, :salary, :salary_ratio, :card_number, :card_owner, :additional_card_number, :additional_card_owner, :shoes_size, :dress_size, :height, :children_count, :mobile_number, :phone_number, :address, :residential_address, :emergency_name, :emergency_phone, :avatar, :avatar_original_w, :avatar_original_h, :avatar_box_w, :avatar_aspect, :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h, :passport_front, :passport_reg, :additional_document_1, :additional_document_2, :additional_document_3)
  end
  def employee_note_params
    params.require(:employee_note).permit(:employee_id, :val)
  end
end
