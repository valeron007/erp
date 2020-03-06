class AddFacilityToSTools < ActiveRecord::Migration
  def change
    add_reference :s_tools, :facility, index: true, foreign_key: true
  end
end
