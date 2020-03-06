class RenamePositionTitle < ActiveRecord::Migration
  def up
    rename_column :positions, :title, :name
  end
  def down
    rename_column :positions, :name, :title
  end
end
