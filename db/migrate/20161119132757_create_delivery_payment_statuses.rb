class CreateDeliveryPaymentStatuses < ActiveRecord::Migration
  def change
    create_table :delivery_payment_statuses do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
