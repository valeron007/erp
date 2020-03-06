class AddFilesToSTools < ActiveRecord::Migration
  def change
    add_column :s_tools, :s_tool_files, :text
  end
end
