class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /facilities
  # GET /facilities.json
  def index
    authorize Facility
    @filterrific = initialize_filterrific(
        Facility,
        params[:filterrific],
        select_options: {
            with_facility_status_id: FacilityStatus.options_for_name_select
        }
    ) or return

    #@facilities = @filterrific.find.for_foreman(current_user).page(params[:page])
    @selected_per_page = get_session_per_page(Facility.per_page)
    @facilities = @filterrific.find.for_foreman(current_user).page(params[:page]).per_page(@selected_per_page)
    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
    authorize @facility
    @facility_note = FacilityNote.new(facility: @facility)
    set_return_to
    @return_to = get_return_to_or_default facilities_url

    @additional_list = Array.new
    @material_list = Array.new
    @other_list = Array.new
    @tool_list = Array.new

    income_transactions = STransaction.in_facility(@facility).to_a

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
       	  @other_list[idx].s_amount ||= 0
          @other_list[idx].s_amount += other.s_amount.to_s.to_d
        end
      }

      transaction.s_transaction_tools.each { |tool|
        @tool_list << tool
      }

    }

    outcome_transactions = STransaction.out_facility(@facility).to_a

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
         if @material_list[idx].s_amount < 0 
          then 
          $xrel = 1
          else
          $xrel = 0
         end
         end
       }

      transaction.s_transaction_others.each { |other|
        idx = @other_list.find_index {|obj| obj.s_other.id == other.s_other.id}
        if !idx.blank? && @other_list[idx].s_amount.present? && other.s_amount.present?
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

  # GET /facilities/new
  def new
    @facility = Facility.new
    authorize @facility
    @facility.adocs.build if @facility.adocs.blank?
    @facility.facility_work_types.build if @facility.facility_work_types.blank?
    @facility.facility_tools.build if @facility.facility_tools.blank?
    @facility.facility_materials.build if @facility.facility_materials.blank?
    @facility.facility_others.build if @facility.facility_others.blank?
    @facility.facility_additionals.build if @facility.facility_additionals.blank?
    @facility.facility_costs.build if @facility.facility_costs.blank?
    set_return_to
    @return_to = get_return_to_or_default facilities_url
  end

  # GET /facilities/1/edit
  def edit
    authorize @facility
    @facility.adocs.build if @facility.adocs.blank?
    @facility.facility_work_types.build if @facility.facility_work_types.blank?
    @facility.facility_tools.build if @facility.facility_tools.blank?
    @facility.facility_materials.build if @facility.facility_materials.blank?
    @facility.facility_others.build if @facility.facility_others.blank?
    @facility.facility_additionals.build if @facility.facility_additionals.blank?
    @facility.facility_costs.build if @facility.facility_costs.blank?
    set_return_to
    @return_to = get_return_to_or_default facilities_url
  end

  # POST /facilities
  # POST /facilities.json
  def create
    @facility = Facility.new(facility_params)
    @facility.foreman = current_user if current_user.foreman?
    authorize @facility
    respond_to do |format|
      if @facility.save
        format.html { redirect_back_or_default facilities_url, t('Record has been saved') }
        format.json { render :show, status: :created, location: @facility }
      else
        format.html {
          @facility.adocs.build if @facility.adocs.blank?
          @facility.facility_work_types.build if @facility.facility_work_types.blank?
          @facility.facility_tools.build if @facility.facility_tools.blank?
          @facility.facility_materials.build if @facility.facility_materials.blank?
          @facility.facility_others.build if @facility.facility_others.blank?
          @facility.facility_additionals.build if @facility.facility_additionals.blank?
          @facility.facility_costs.build if @facility.facility_costs.blank?
          render :new
        }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facilities/1
  # PATCH/PUT /facilities/1.json
  def update
    authorize @facility
    respond_to do |format|
      if @facility.update(facility_params)
        format.html { redirect_back_or_default facilities_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @facility }
      else
        format.html {
          @facility.adocs.build if @facility.adocs.blank?
          @facility.facility_work_types.build if @facility.facility_work_types.blank?
          @facility.facility_tools.build if @facility.facility_tools.blank?
          @facility.facility_materials.build if @facility.facility_materials.blank?
          @facility.facility_others.build if @facility.facility_others.blank?
          @facility.facility_additionals.build if @facility.facility_additionals.blank?
          @facility.facility_costs.build if @facility.facility_costs.blank?
          render :edit
        }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    authorize @facility
    set_return_to
    @facility.destroy
    respond_to do |format|
      format.html { redirect_back_or_default facilities_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  def destroy_note
    @facility_note = FacilityNote.find_by_id(params[:id])
    @facility = @facility_note.facility
    authorize @facility
    @facility_note.destroy

    respond_to do |format|
      format.html { redirect_to facility_url(@facility), notice: t('Note removed') }
      format.json { head :no_content }
    end
  end

  def create_note
    @facility_note = FacilityNote.new(facility_note_params)
    @facility = @facility_note.facility
    authorize @facility
    @facility_note.user = current_user

    respond_to do |format|
      if @facility_note.save
        format.html { redirect_to facility_url(@facility), notice: t('Note added') }
        format.json { render :show, status: :created, location: @facility_note.facility }
      else
        format.html { render :show }
        format.json { render json: @facility_note.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_params
      params.require(:facility).permit(
          :doer,
          :customer,
          :full_name,
          :name,
          :address,
          :contact_name,
          :foreman_id,
          :facility_status_id,
          :status_change_date,
          :projected_start_date,
          :contract_number,
          :contract_date,
          :finish_date,
          :p_total,
          :p_paid,
          :p_left,
          :lead_id,
          :client_id,
          adocs_attributes: [:id, :index_number, :name, :number, :date, :present, :adoc_status_id, :adoc_name_id, :amount, :_destroy],
          facility_work_types_attributes: [:id, :work_type_id, :amount, :total_price, :_destroy],
          facility_tools_attributes: [:id, :tool_id, :amount, :_destroy],
          facility_materials_attributes: [:id, :material_id, :amount, :total_price, :_destroy],
          facility_others_attributes: [:id, :other_id, :amount, :total_price, :_destroy],
          facility_additionals_attributes: [:id, :additional_id, :amount, :total_price, :_destroy],
          facility_costs_attributes: [:id, :title, :amount, :_destroy],
      )
    end

    def facility_note_params
      params.require(:facility_note).permit(:facility_id, :val, :updated_by)
    end
end
