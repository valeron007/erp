class AddDriverIdToSTransactions < ActiveRecord::Migration
  def change
    add_reference :s_transactions, :driver, index: true
    add_foreign_key :s_transactions, :users, column: :driver_id
  end
end
