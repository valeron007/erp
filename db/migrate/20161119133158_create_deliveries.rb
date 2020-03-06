class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :name
      t.integer :count
      t.references :unit, index: true, foreign_key: true
      t.references :contractor, index: true, foreign_key: true
      t.string :city
      t.string :address
      t.references :transport_company, index: true, foreign_key: true
      t.float :volume
      t.date :dispatch_date
      t.date :arrival_date
      t.float :delivery_cost
      t.float :delivery_perunit
      t.references :delivery_payment_status, index: true, foreign_key: true
      t.references :delivery_status, index: true, foreign_key: true
      t.float :cost
      t.float :total_with_delivery
      t.boolean :vat
      t.references :delivery_document, index: true, foreign_key: true
      t.references :delivery_letter, index: true, foreign_key: true
      t.references :delivery_dest, index: true, foreign_key: true
      t.date :order_date
      t.references :commodity_type, index: true, foreign_key: true
      t.string :pack

      t.timestamps null: false
    end
  end
end
