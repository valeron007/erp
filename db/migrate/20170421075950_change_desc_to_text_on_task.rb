class ChangeDescToTextOnTask < ActiveRecord::Migration
  def up
    change_column :tasks, :desc, :text
  end
  def down
    change_column :tasks, :desc, :string
  end
end
