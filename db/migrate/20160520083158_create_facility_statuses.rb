class CreateFacilityStatuses < ActiveRecord::Migration
  def change
    create_table :facility_statuses do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
