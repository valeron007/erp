class AddFieldsToTools < ActiveRecord::Migration
  def change
    add_column :tools, :document_name, :string
    add_reference :tools, :inventory_type, index: true, foreign_key: true
  end
end
