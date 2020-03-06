class CreateFacilityNotes < ActiveRecord::Migration
  def change
    create_table :facility_notes do |t|
      t.references :facility, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :val

      t.timestamps null: false
    end
  end
end
