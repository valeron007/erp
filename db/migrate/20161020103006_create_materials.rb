class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.references :unit, index: true, foreign_key: true
      t.decimal :price_per_unit

      t.timestamps null: false
    end
  end
end
