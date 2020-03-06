class AddNameToAdocs < ActiveRecord::Migration
  def change
    add_column :adocs, :name, :string
  end
end
