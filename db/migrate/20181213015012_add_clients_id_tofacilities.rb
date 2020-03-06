class AddClientsIdTofacilities < ActiveRecord::Migration
  def change
  	add_reference :facilities, :client, index: true, foreign_key: true
  end
end
