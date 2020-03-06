class AddInventoryNumberToSTools < ActiveRecord::Migration
  def change
    add_column :s_tools, :inventory_number, :string
  end
end
