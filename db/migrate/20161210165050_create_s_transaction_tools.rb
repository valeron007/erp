class CreateSTransactionTools < ActiveRecord::Migration
  def change
    create_table :s_transaction_tools do |t|
      t.references :s_tool, index: true, foreign_key: true
      t.references :s_transaction, index: true, foreign_key: true
      t.string :s_tool_state
      t.float :s_amount
      t.text :s_comment

      t.timestamps null: false
    end
  end
end
