class CreateFacilityMaterials < ActiveRecord::Migration
  def change
    create_table :facility_materials do |t|
      t.references :facility, index: true, foreign_key: true
      t.references :material, index: true, foreign_key: true
      t.float :amount
      t.float :total_price

      t.timestamps null: false
    end
  end
end
