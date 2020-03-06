class ChangeFacilityFloatLimit < ActiveRecord::Migration
  def change
    change_column :facilities, :p_total, :decimal, :precision => 12, :scale => 2
    change_column :facilities, :p_paid, :decimal, :precision => 12, :scale => 2
    change_column :facilities, :p_left, :decimal, :precision => 12, :scale => 2
  end
end
