class AddPricePerUnitToTools < ActiveRecord::Migration
  def change
    add_column :tools, :price_per_unit, :decimal, :precision => 16, :scale => 2
  end
end
