class CreateSMaterials < ActiveRecord::Migration
  def change
    create_table :s_materials do |t|
      t.string :pack
      t.float :amount
      t.references :unit, index: true, foreign_key: true
      t.float :min_amount
      t.string :storage_place
      t.text :comments

      t.timestamps null: false
    end
    add_column :s_materials, :name_id, :integer
    add_index :s_materials, :name_id
    add_foreign_key :s_materials, :materials, column: :name_id
  end
end
