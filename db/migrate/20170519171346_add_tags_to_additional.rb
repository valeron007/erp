class AddTagsToAdditional < ActiveRecord::Migration
  def change
    add_column :additionals, :tags, :string
  end
end
