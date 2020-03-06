class CreateFacilityCosts < ActiveRecord::Migration
  def change
    create_table :facility_costs do |t|
      t.references :facility, index: true, foreign_key: true
      t.string :title
      t.float :amount

      t.timestamps null: false
    end
  end
end
