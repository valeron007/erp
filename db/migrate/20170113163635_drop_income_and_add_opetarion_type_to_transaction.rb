class DropIncomeAndAddOpetarionTypeToTransaction < ActiveRecord::Migration
  def change
    remove_column :s_transactions, :income
    add_column :s_transactions, :operation_type, :string
  end
end
