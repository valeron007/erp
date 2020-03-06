class CreateDailyTimesheetStatuses < ActiveRecord::Migration
  def change
    create_table :daily_timesheet_statuses do |t|
      t.string :name
      t.string :color

      t.timestamps null: false
    end
  end
end
