class CreateFacilityWorkTypes < ActiveRecord::Migration
  def change
    create_table :facility_work_types do |t|
      t.references :facility, index: true, foreign_key: true
      t.references :work_type, index: true, foreign_key: true
      t.float :amount
      t.float :total_price

      t.timestamps null: false
    end
  end
end
