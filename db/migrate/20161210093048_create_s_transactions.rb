class CreateSTransactions < ActiveRecord::Migration
  def change
    create_table :s_transactions do |t|
      t.date :date
      t.text :comments

      t.timestamps null: false
    end
    add_reference :s_transactions, :destination, index: true
    add_foreign_key :s_transactions, :facilities, column: :destination_id
    add_reference :s_transactions, :user_from, index: true
    add_foreign_key :s_transactions, :users, column: :user_from_id
    add_reference :s_transactions, :user_to, index: true
    add_foreign_key :s_transactions, :users, column: :user_to_id
  end
end
