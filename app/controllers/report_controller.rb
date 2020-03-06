class ReportController < ApplicationController
  after_action :verify_authorized

  def dashboard
    authorize :report
  end

  def employee_payments
    authorize :report

    if request.post?
      @f = ReportFilter.new(employee_payments_filter_params)
      dates = @f.date_range.split(' - ')
      @f.date_from = dates[0]
      @f.date_to = dates[1]

      @data = Employee.get_timesheets(
          @f.employee_name,
          @f.date_from,
          @f.date_to
      )

      respond_to do |format|
        format.js
        format.xlsx { render xlsx: 'employee_payments_report', template: 'report/employee_payments' }
      end


    else
      @filter = ReportFilter.new
    end
  end

  def employee_payments_filter_params
    params.require(:report_controller_report_filter).permit(:employee_name, :date_range)
  end

  def facility_works
    authorize :report

    if request.post?
      @f = ReportFilter.new(facility_works_filter_params)
      dates = @f.date_range.split(' - ')
      @f.date_from = dates[0]
      @f.date_to = dates[1]
      if @f.employee_name.blank?
        terms = []
      else
        terms = @f.employee_name.to_s.mb_chars.downcase.split(/\s+/)
      end

      @data = RawSQL.new('facility_works_report.sql').result(
          facility_id: @f.facility_id,
          employee_name: (terms.size>0?"#{terms[0]}":''),
          date_from: (@f.date_from.blank? ? '' : DateTime.parse(@f.date_from)),
          date_to: (@f.date_to.blank? ? '' : DateTime.parse(@f.date_to)),
          draft_status_id: DailyTimesheetStatus.draft.id
      ).to_a

      @filter_facility = ''
      @filter_facility = Facility.find_by_id(@f.facility_id) unless @f.facility_id.blank?

      respond_to do |format|
        format.js
        format.xlsx { render xlsx: 'facility_works_report', template: 'report/facility_works' }
      end


    else
      @filter = ReportFilter.new
    end

  end

  def facility_works_filter_params
    params.require(:report_controller_report_filter).permit(:facility_id, :employee_name, :date_range)
  end

  def labor_costs
    authorize :report

    if request.post?
      @f = ReportFilter.new(labor_costs_filter_params)
      dates = @f.date_range.split(' - ')
      @f.date_from = dates[0]
      @f.date_to = dates[1]

      @filter_facility = ''
      @filter_facility = Facility.find_by_id(@f.facility_id) unless @f.facility_id.blank?

      @data = Employee.get_timesheets(
          @f.employee_name,
          @f.date_from,
          @f.date_to,
          @filter_facility
      )

      respond_to do |format|
        format.js
        format.xlsx { render xlsx: 'labor_costs_report', template: 'report/labor_costs' }
      end


    else
      @filter = ReportFilter.new
    end
  end

  def labor_costs_filter_params
    params.require(:report_controller_report_filter).permit(:facility_id, :employee_name, :date_range)
  end

  def work_efficiency
    authorize :report

    if request.post?
      @f = ReportFilter.new(employee_payments_filter_params)
      dates = @f.date_range.split(' - ')
      @f.date_from = dates[0]
      @f.date_to = dates[1]

      @data = Employee.get_timesheets(
          @f.employee_name,
          @f.date_from,
          @f.date_to
      )

      respond_to do |format|
        format.js
        format.xlsx { render xlsx: 'work_efficiency_report', template: 'report/work_efficiency' }
      end


    else
      @filter = ReportFilter.new
    end

  end

  def daily_summary
    authorize :report

    if request.post?
      @f = ReportFilter.new(daily_summary_filter_params)
      dates = @f.date_range.split(' - ')
      @f.date_from = dates[0]
      @f.date_to = dates[1]

      @data = RawSQL.new('daily_summary_report.sql').result(
          facility_id: @f.facility_id,
          date_from: (@f.date_from.blank? ? '' : DateTime.parse(@f.date_from)),
          date_to: (@f.date_to.blank? ? '' : DateTime.parse(@f.date_to)),
          draft_status_id: DailyTimesheetStatus.draft.id
      ).to_a

      @filter_facility = ''
      @filter_facility = Facility.find_by_id(@f.facility_id) unless @f.facility_id.blank?

      respond_to do |format|
        format.js
        format.xlsx { render xlsx: 'daily_summary_report', template: 'report/daily_summary' }
      end


    else
      @filter = ReportFilter.new
    end

  end

  def daily_summary_filter_params
    params.require(:report_controller_report_filter).permit(:facility_id, :date_range)
  end

  def calc
    authorize :report
    @facility = Facility.new
    @facility.facility_work_types.build if @facility.facility_work_types.blank?
    @facility.facility_tools.build if @facility.facility_tools.blank?
    @facility.facility_materials.build if @facility.facility_materials.blank?
    @facility.facility_others.build if @facility.facility_others.blank?
    @facility.facility_additionals.build if @facility.facility_additionals.blank?
  end
end
