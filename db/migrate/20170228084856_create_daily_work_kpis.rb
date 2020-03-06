class CreateDailyWorkKpis < ActiveRecord::Migration
  def change
    create_table :daily_work_kpis do |t|
      t.references :daily_work, index: true, foreign_key: true
      t.references :kpi, index: true, foreign_key: true
      t.text :comment

      t.timestamps null: false
    end
  end
end
