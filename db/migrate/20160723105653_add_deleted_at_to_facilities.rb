class AddDeletedAtToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :deleted_at, :datetime
    add_index :facilities, :deleted_at
  end
end
