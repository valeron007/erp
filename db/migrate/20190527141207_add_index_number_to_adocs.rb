class AddIndexNumberToAdocs < ActiveRecord::Migration
  def change
    add_column :adocs, :index_number, :integer
  end
end
