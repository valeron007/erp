class CreateDeliveryDests < ActiveRecord::Migration
  def change
    create_table :delivery_dests do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
