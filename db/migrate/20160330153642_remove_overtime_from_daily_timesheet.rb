class RemoveOvertimeFromDailyTimesheet < ActiveRecord::Migration
  def change
    remove_column :daily_timesheets, :overtime, :integer
  end
end
