class AddAdditionalCardOwnerToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :additional_card_owner, :string
  end
end
