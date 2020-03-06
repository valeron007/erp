class AddOrderNumberToDeliveryStatuses < ActiveRecord::Migration
  def change
    add_column :delivery_statuses, :order_number, :integer
  end
end
