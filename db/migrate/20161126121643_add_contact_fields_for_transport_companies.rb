class AddContactFieldsForTransportCompanies < ActiveRecord::Migration
  def change
    add_column :transport_companies, :address, :string
    add_column :transport_companies, :phone, :string
    add_column :transport_companies, :email, :string
    add_column :transport_companies, :contacts, :text
  end
end
