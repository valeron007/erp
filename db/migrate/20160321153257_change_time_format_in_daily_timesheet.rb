class ChangeTimeFormatInDailyTimesheet < ActiveRecord::Migration
  def up
    change_column :daily_timesheets, :start_time, :time
    change_column :daily_timesheets, :end_time, :time
  end

  def down
    change_column :daily_timesheets, :start_time, :datetime
    change_column :daily_timesheets, :end_time, :datetime
  end
end
