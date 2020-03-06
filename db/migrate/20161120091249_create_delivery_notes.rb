class CreateDeliveryNotes < ActiveRecord::Migration
  def change
    create_table :delivery_notes do |t|
      t.references :delivery, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :val

      t.timestamps null: false
    end
  end
end
