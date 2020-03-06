class CreateFacilityOthers < ActiveRecord::Migration
  def change
    create_table :facility_others do |t|
      t.references :facility, index: true, foreign_key: true
      t.references :other, index: true, foreign_key: true
      t.float :amount
      t.float :total_price

      t.timestamps null: false
    end
  end
end
