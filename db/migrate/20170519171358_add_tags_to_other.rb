class AddTagsToOther < ActiveRecord::Migration
  def change
    add_column :others, :tags, :string
  end
end
