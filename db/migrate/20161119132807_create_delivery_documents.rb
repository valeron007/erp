class CreateDeliveryDocuments < ActiveRecord::Migration
  def change
    create_table :delivery_documents do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
