class AddVolumeUnitFieldToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :volume_unit_id, :integer
    add_index :deliveries, :volume_unit_id
    add_foreign_key :deliveries, :units, column: :volume_unit_id
  end
end
