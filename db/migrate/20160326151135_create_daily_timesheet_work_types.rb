class CreateDailyTimesheetWorkTypes < ActiveRecord::Migration
  def change
    create_table :daily_timesheet_work_types do |t|
      t.references :daily_timesheet, index: true, foreign_key: true
      t.references :work_type, index: true, foreign_key: true
      t.float :amount

      t.timestamps null: false
    end
  end
end
