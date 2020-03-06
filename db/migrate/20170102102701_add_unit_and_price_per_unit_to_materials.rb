class AddUnitAndPricePerUnitToMaterials < ActiveRecord::Migration
  def change
    add_reference :others, :unit, index: true, foreign_key: true
    add_column :others, :price_per_unit, :decimal
  end
end
