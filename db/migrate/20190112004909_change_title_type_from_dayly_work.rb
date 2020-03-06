class ChangeTitleTypeFromDaylyWork < ActiveRecord::Migration
  def change
  	change_column :daily_work_kpis, :title, :text
  end
end
