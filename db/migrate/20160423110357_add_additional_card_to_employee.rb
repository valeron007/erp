class AddAdditionalCardToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :additional_card_number, :string
  end
end
