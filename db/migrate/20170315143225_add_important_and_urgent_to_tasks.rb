class AddImportantAndUrgentToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :important, :boolean
    add_column :tasks, :urgent, :boolean
  end
end
