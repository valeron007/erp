class AddMoreFieldsToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :finish_date, :datetime
    add_column :facilities, :p_total, :float
    add_column :facilities, :p_paid, :float
    add_column :facilities, :p_left, :float
  end
end
