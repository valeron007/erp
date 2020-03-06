class AddTaskToDailyWorkKpi < ActiveRecord::Migration
  def change
    add_reference :daily_work_kpis, :task, index: true, foreign_key: true
  end
end
