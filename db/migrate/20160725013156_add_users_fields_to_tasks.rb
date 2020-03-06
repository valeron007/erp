class AddUsersFieldsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :assigned_by_id, :integer
    add_column :tasks, :assigned_to_id, :integer
    add_column :tasks, :created_by_id, :integer
    add_column :tasks, :updated_by_id, :integer

    add_index :tasks, :assigned_by_id
    add_foreign_key :tasks, :users, column: :assigned_by_id

    add_index :tasks, :assigned_to_id
    add_foreign_key :tasks, :users, column: :assigned_to_id

    add_index :tasks, :created_by_id
    add_foreign_key :tasks, :users, column: :created_by_id

    add_index :tasks, :updated_by_id
    add_foreign_key :tasks, :users, column: :updated_by_id
  end
end
