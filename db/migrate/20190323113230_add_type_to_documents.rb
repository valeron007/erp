class AddTypeToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :type, :integer, default: 0
  end
end
