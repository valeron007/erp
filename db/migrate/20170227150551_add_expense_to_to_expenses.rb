class AddExpenseToToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :expense_to_id, :integer
    add_index :expenses, :expense_to_id
    add_foreign_key :expenses, :users, column: :expense_to_id
  end
end
