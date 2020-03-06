json.array!(@daily_timesheets) do |daily_timesheet|
  json.extract! daily_timesheet, :id, :facility_id, :employee_id, :date, :start_time, :end_time, :salary_period_id, :rework, :penalty_id, :quality_penalty_id, :penalty_description, :probation_period, :payment_type_id, :ratio, :salary, :overtime, :description, :total_amount, :work_type_id
  json.url daily_timesheet_url(daily_timesheet, format: :json)
end
