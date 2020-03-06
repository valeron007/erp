class AddFilesToSOthers < ActiveRecord::Migration
  def change
    add_column :s_others, :s_other_files, :text
  end
end
