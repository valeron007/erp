class AddFilesToSMaterials < ActiveRecord::Migration
  def change
    add_column :s_materials, :s_material_files, :text
  end
end
