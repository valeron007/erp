class AddFieldsToOthers < ActiveRecord::Migration
  def change
    add_column :others, :document_name, :string
    add_reference :others, :inventory_type, index: true, foreign_key: true
  end
end
