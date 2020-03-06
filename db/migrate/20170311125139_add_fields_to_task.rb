class AddFieldsToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :done_date, :datetime
    add_column :tasks, :result, :text
  end
end
