class DeleteKpisPositions < ActiveRecord::Migration
  def change
    drop_table :kpis_positions
  end
end
