class AddFileToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :contractor_files, :text
  end
end
