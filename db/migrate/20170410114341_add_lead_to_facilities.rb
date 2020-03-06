class AddLeadToFacilities < ActiveRecord::Migration
  def change
    add_reference :facilities, :lead, index: true, foreign_key: true
  end
end
