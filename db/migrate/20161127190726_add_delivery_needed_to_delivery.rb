class AddDeliveryNeededToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :delivery_needed, :boolean
  end
end
