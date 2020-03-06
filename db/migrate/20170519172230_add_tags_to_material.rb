class AddTagsToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :tags, :string
  end
end
