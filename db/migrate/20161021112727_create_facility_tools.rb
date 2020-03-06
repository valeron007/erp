class CreateFacilityTools < ActiveRecord::Migration
  def change
    create_table :facility_tools do |t|
      t.references :facility, index: true, foreign_key: true
      t.references :tool, index: true, foreign_key: true
      t.float :amount

      t.timestamps null: false
    end
  end
end
