class AddIncomeToSTransactions < ActiveRecord::Migration
  def change
    add_column :s_transactions, :income, :boolean, default: false
  end
end
