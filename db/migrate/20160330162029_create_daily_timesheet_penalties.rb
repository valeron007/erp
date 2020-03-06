class CreateDailyTimesheetPenalties < ActiveRecord::Migration
  def change
    create_table :daily_timesheet_penalties do |t|
      t.references :daily_timesheet, index: true, foreign_key: true
      t.references :penalty, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
