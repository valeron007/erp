class AddEmployeeToDailyTimesheetPenalty < ActiveRecord::Migration
  def change
    add_reference :daily_timesheet_penalties, :employee, index: true, foreign_key: true
  end
end
