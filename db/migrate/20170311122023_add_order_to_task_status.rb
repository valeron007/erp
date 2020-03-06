class AddOrderToTaskStatus < ActiveRecord::Migration
  def change
    add_column :task_statuses, :order, :integer
  end
end
