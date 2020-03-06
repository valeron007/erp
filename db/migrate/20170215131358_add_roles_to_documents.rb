class AddRolesToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :roles, :string
  end
end
