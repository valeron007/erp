class CreateDailyTimesheets < ActiveRecord::Migration
  def change
    create_table :daily_timesheets do |t|
      t.references :facility, index: true, foreign_key: true
      t.references :employee, index: true, foreign_key: true
      t.date :date
      t.datetime :start_time
      t.datetime :end_time
      t.references :salary_period, index: true, foreign_key: true
      t.boolean :rework
      t.text :penalty_description
      t.boolean :probation_period
      t.references :payment_type, index: true, foreign_key: true
      t.float :ratio
      t.float :salary
      t.integer :overtime
      t.text :description
      t.float :total_amount

      t.timestamps null: false
    end
  end
end
