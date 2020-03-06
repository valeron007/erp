class AddUnitToWorkType < ActiveRecord::Migration
  def change
    add_reference :work_types, :unit, index: true, foreign_key: true
  end
end
