class AddFacilityStatusToFacility < ActiveRecord::Migration
  def change
    add_reference :facilities, :facility_status, index: true, foreign_key: true
  end
end
