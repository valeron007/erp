class AddContactFieldsForContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :address, :string
    add_column :contractors, :phone, :string
    add_column :contractors, :email, :string
    add_column :contractors, :contacts, :text

    add_column :contractors, :storage_address, :string
  end
end
