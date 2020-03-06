class DropAmountToTools < ActiveRecord::Migration
  def change
      remove_column :s_transaction_tools, :s_amount
      remove_column :s_tools, :amount
  end
end
