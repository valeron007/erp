class ChangeFacilityColumn < ActiveRecord::Migration
  def up
    change_column :facilities, :finish_date, :date
  end
  def down
    change_column :facilities, :finish_date, :datetime
  end
end
