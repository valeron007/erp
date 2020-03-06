class AddFieldToClients < ActiveRecord::Migration
  def change
    add_column :clients, :address, :string
    add_column :clients, :phone, :string
    add_column :clients, :comment, :text
  end
end
