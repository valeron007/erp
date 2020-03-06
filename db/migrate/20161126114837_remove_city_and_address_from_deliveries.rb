class RemoveCityAndAddressFromDeliveries < ActiveRecord::Migration
  def change
    remove_column :deliveries, :city, :string
    remove_column :deliveries, :address, :string
  end
end
