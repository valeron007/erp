class UpdateTransactionDate < ActiveRecord::Migration
  def change
    change_column :s_transactions, :date, :datetime
  end
end
