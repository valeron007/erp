class AddHoursToDailyWorkKpi < ActiveRecord::Migration
  def change
    add_column :daily_work_kpis, :hours, :float
  end
end
