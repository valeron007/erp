class AddTitleToDailyWorkKpi < ActiveRecord::Migration
  def change
    add_column :daily_work_kpis, :title, :string
  end
end
