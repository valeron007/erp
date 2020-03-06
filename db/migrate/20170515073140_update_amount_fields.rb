class UpdateAmountFields < ActiveRecord::Migration
  def change
    change_column :s_transaction_additionals, :s_amount, :decimal, :precision => 16, :scale => 3
    change_column :s_additionals, :amount, :decimal, :precision => 16, :scale => 3
    change_column :s_additionals, :min_amount, :decimal, :precision => 16, :scale => 3

    change_column :s_transaction_materials, :s_amount, :decimal, :precision => 16, :scale => 3
    change_column :s_materials, :amount, :decimal, :precision => 16, :scale => 3
    change_column :s_materials, :min_amount, :decimal, :precision => 16, :scale => 3

    change_column :s_transaction_others, :s_amount, :decimal, :precision => 16, :scale => 3
    change_column :s_others, :amount, :decimal, :precision => 16, :scale => 3
    change_column :s_others, :min_amount, :decimal, :precision => 16, :scale => 3
  end
end
