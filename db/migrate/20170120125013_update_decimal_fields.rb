class UpdateDecimalFields < ActiveRecord::Migration
  def change
    change_column :leads, :sum_contract, :decimal, :precision => 16, :scale => 2
    change_column :leads, :sum_payment, :decimal, :precision => 16, :scale => 2
    change_column :leads, :debt, :decimal, :precision => 16, :scale => 2
    change_column :expenses, :amount, :decimal, :precision => 16, :scale => 2
    change_column :adocs, :amount, :decimal, :precision => 16, :scale => 2
    change_column :materials, :price_per_unit, :decimal, :precision => 16, :scale => 2
    change_column :others, :price_per_unit, :decimal, :precision => 16, :scale => 2
  end
end
