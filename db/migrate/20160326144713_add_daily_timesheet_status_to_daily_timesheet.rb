class AddDailyTimesheetStatusToDailyTimesheet < ActiveRecord::Migration
  def change
    add_reference :daily_timesheets, :daily_timesheet_status, index: true, foreign_key: true
  end
end
