class AddFieldsToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :doer, :string
    add_column :facilities, :customer, :string
    add_column :facilities, :full_name, :string
    add_column :facilities, :contact_name, :string
    add_column :facilities, :contract_number, :string
    add_column :facilities, :contract_date, :date

    add_column :facilities, :foreman_id, :integer
    add_index :facilities, :foreman_id
    add_foreign_key :facilities, :users, column: :foreman_id
  end
end
