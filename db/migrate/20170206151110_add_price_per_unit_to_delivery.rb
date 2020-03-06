class AddPricePerUnitToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :price_per_unit, :float
  end
end
