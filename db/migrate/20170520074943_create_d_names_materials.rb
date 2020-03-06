class CreateDNamesMaterials < ActiveRecord::Migration
  def change
    create_table :d_names_materials do |t|
      t.references :d_name, index: true, foreign_key: true
      t.references :material, index: true, foreign_key: true
    end
  end
end
