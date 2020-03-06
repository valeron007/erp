class AddFieldsToAdditionals < ActiveRecord::Migration
  def change
    add_column :additionals, :document_name, :string
    add_reference :additionals, :inventory_type, index: true, foreign_key: true
  end
end
