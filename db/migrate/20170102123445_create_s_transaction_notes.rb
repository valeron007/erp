class CreateSTransactionNotes < ActiveRecord::Migration
  def change
    create_table :s_transaction_notes do |t|
      t.references :s_transaction, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :val

      t.timestamps null: false
    end
  end
end
