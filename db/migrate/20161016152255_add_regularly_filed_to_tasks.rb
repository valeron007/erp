class AddRegularlyFiledToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :regularly, :boolean
  end
end
