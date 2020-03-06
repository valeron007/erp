class AddFieldsToFacility < ActiveRecord::Migration
  def change
    add_column :facilities, :projected_start_date, :date
    add_column :facilities, :status_change_date, :date
  end
end
