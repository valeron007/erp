class AddFacilityToAdoc < ActiveRecord::Migration
  def change
    add_reference :adocs, :facility, index: true, foreign_key: true
  end
end
