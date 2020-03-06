class RenamePriceToPricePerUnitInWorkType < ActiveRecord::Migration
  def change
    rename_column :work_types, :price, :price_per_unit
  end
end
