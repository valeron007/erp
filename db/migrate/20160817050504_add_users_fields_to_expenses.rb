class AddUsersFieldsToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :expense_by_id, :integer
    add_column :expenses, :created_by_id, :integer
    add_column :expenses, :updated_by_id, :integer

    add_index :expenses, :expense_by_id
    add_foreign_key :expenses, :users, column: :expense_by_id

    add_index :expenses, :created_by_id
    add_foreign_key :expenses, :users, column: :created_by_id

    add_index :expenses, :updated_by_id
    add_foreign_key :expenses, :users, column: :updated_by_id
  end
end
