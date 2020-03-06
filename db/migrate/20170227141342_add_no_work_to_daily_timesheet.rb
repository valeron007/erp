class AddNoWorkToDailyTimesheet < ActiveRecord::Migration
  def change
    add_column :daily_timesheets, :no_work, :boolean
  end
end
