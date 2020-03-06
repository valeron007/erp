class AddTagsToTool < ActiveRecord::Migration
  def change
    add_column :tools, :tags, :string
  end
end
