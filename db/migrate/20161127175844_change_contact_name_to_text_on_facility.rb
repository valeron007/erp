class ChangeContactNameToTextOnFacility < ActiveRecord::Migration
  def up
    change_column :facilities, :contact_name, :text
  end
  def down
    change_column :facilities, :contact_name, :string
  end
end
