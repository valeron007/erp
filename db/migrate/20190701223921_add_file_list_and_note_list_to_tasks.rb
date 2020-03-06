class AddFileListAndNoteListToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :file_list, :text
    add_column :tasks, :note_list, :text
  end
end
