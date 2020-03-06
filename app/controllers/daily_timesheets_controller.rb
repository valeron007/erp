class DailyTimesheetsController < ApplicationController
  include ActionView::Helpers::DateHelper

  before_action :set_daily_timesheet, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def export
    authorize DailyTimesheet

    @filterrific = initialize_filterrific(
        DailyTimesheet,
        params[:filterrific],
        select_options: {
            with_employee_id: Employee.options_for_select,
            with_facility_id: Facility.reportable.options_for_select,
            with_status_id: DailyTimesheetStatus.options_for_select,
        }
    ) or return

    #@daily_timesheets = @filterrific.find.for_foreman(current_user)
    @daily_timesheets = @filterrific.find


    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="dailytimesheets_export.xlsx"'
      }
    end

  end
  # GET /daily_timesheets
  # GET /daily_timesheets.json
  def index
    authorize DailyTimesheet

    @filterrific = initialize_filterrific(
        DailyTimesheet,
        params[:filterrific],
        select_options: {
            with_employee_id: Employee.options_for_select,
            with_facility_id: Facility.reportable.options_for_select,
            with_status_id: DailyTimesheetStatus.options_for_select,
            with_payment_type_id: PaymentType.options_for_select,
        }
    ) or return

    #@daily_timesheets = @filterrific.find.for_foreman(current_user).page(params[:page])
    @filterrific.sorted_by = 'date_desc' if @filterrific.sorted_by.blank?
    @selected_per_page = get_session_per_page(DailyTimesheet.per_page)
    @daily_timesheets = @filterrific.find.page(params[:page]).per_page(@selected_per_page)
    @total = @filterrific.find.sum_total
    @penalty = @filterrific.find.sum_penalty
    @workhours = @filterrific.find.sum_workhours

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end

  # GET /daily_timesheets/1
  # GET /daily_timesheets/1.json
  def show
    authorize @daily_timesheet
    set_return_to
    @return_to = get_return_to_or_default daily_timesheets_url
  end

  # GET /daily_timesheets/new
  def new
    @daily_timesheet = DailyTimesheet.new
    authorize @daily_timesheet
    @penalty = Penalty.new
    @work_types = WorkType.all
    @penalties = Penalty.all
    @daily_timesheet.daily_timesheet_work_types.build
    @daily_timesheet.daily_timesheet_penalties.build
    set_return_to
    @return_to = get_return_to_or_default daily_timesheets_url
  end

  # GET /daily_timesheets/1/edit
  def edit
    authorize @daily_timesheet
    @penalty = Penalty.new
    @work_types = WorkType.all
    @penalties = Penalty.all
    @daily_timesheet.daily_timesheet_work_types.build if @daily_timesheet.daily_timesheet_work_types.blank?
    @daily_timesheet.daily_timesheet_penalties.build if @daily_timesheet.daily_timesheet_penalties.blank?
    set_return_to
    @return_to = get_return_to_or_default daily_timesheets_url
  end

  # POST /daily_timesheets
  # POST /daily_timesheets.json
  def create
    @penalty = Penalty.new
    @daily_timesheet = DailyTimesheet.new(daily_timesheet_params)
    authorize @daily_timesheet
    @work_types = WorkType.all
    @penalties = Penalty.all
    respond_to do |format|
      if @daily_timesheet.save
        format.html { redirect_back_or_default daily_timesheets_url, t('Record has been saved') }
        format.json { render :show, status: :created, location: @daily_timesheet }
      else
        format.html {
          @daily_timesheet.daily_timesheet_work_types.build if @daily_timesheet.daily_timesheet_work_types.blank?
          @daily_timesheet.daily_timesheet_penalties.build if @daily_timesheet.daily_timesheet_penalties.blank?
          render :new
        }
        format.json { render json: @daily_timesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_timesheets/1
  # PATCH/PUT /daily_timesheets/1.json
  def update
    authorize @daily_timesheet
    @penalty = Penalty.new
    @work_types = WorkType.all
    @penalties = Penalty.all
    respond_to do |format|
      if @daily_timesheet.update(daily_timesheet_params)
        format.html { redirect_back_or_default daily_timesheets_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @daily_timesheet }
      else
        format.html {
          @daily_timesheet.daily_timesheet_work_types.build if @daily_timesheet.daily_timesheet_work_types.blank?
          @daily_timesheet.daily_timesheet_penalties.build if @daily_timesheet.daily_timesheet_penalties.blank?
          render :edit
        }
        format.json { render json: @daily_timesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_timesheets/1
  # DELETE /daily_timesheets/1.json
  def destroy
    authorize @daily_timesheet
    set_return_to
    @daily_timesheet.destroy
    respond_to do |format|
      format.html { redirect_back_or_default daily_timesheets_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_timesheet
      @daily_timesheet = DailyTimesheet.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_timesheet_params
      params.require(:daily_timesheet).permit(
          :facility_id,
          :employee_id,
          :date,
          :start_time,
          :end_time,
          :no_work,
          :salary_period_id,
          :rework,
          :penalty_id,
          :quality_penalty_id,
          :penalty_description,
          :probation_period,
          :payment_type_id,
          :ratio,
          :salary,
          :overtime,
          :description,
          :total_amount,
          :daily_timesheet_status_id,
          :additional_payment_value,
          :additional_payment_reason,
          daily_timesheet_work_types_attributes: [:id, :work_type_id, :amount, :_destroy],
          daily_timesheet_penalties_attributes: [:id, :penalty_id, :employee_id, :_destroy]
      )
    end
end
