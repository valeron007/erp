class AddDeletedAtToSTransactions < ActiveRecord::Migration
  def change
    add_column :s_transactions, :deleted_at, :datetime
    add_index :s_transactions, :deleted_at
  end
end
