class AddFieldsToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :document_name, :string
    add_reference :materials, :inventory_type, index: true, foreign_key: true
  end
end
