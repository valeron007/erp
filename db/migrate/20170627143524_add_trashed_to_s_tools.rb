class AddTrashedToSTools < ActiveRecord::Migration
  def change
    add_column :s_tools, :trashed, :boolean, default: false
  end
end
