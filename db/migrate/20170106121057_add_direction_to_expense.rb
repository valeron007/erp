class AddDirectionToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :direction, :integer
  end
end
