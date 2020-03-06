class AddFileToTransportCompanies < ActiveRecord::Migration
  def change
    add_column :transport_companies, :transport_company_files, :text
  end
end
