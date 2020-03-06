class CreateTransportCompanies < ActiveRecord::Migration
  def change
    create_table :transport_companies do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
