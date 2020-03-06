class CreateDeliveryLetters < ActiveRecord::Migration
  def change
    create_table :delivery_letters do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
