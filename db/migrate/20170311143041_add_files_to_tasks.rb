class AddFilesToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :files, :text
  end
end
