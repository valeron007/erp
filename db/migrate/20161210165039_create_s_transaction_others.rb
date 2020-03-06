class CreateSTransactionOthers < ActiveRecord::Migration
  def change
    create_table :s_transaction_others do |t|
      t.references :s_other, index: true, foreign_key: true
      t.references :s_transaction, index: true, foreign_key: true
      t.float :s_amount

      t.timestamps null: false
    end
  end
end
