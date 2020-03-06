class CreateFacilityAdditionals < ActiveRecord::Migration
  def change
    create_table :facility_additionals do |t|
      t.references :facility, index: true, foreign_key: true
      t.references :additional, index: true, foreign_key: true
      t.float :amount
      t.float :total_price

      t.timestamps null: false
    end
  end
end
