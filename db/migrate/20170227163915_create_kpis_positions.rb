class CreateKpisPositions < ActiveRecord::Migration
  def change
    create_table :kpis_positions do |t|
      t.references :kpi, index: true, foreign_key: true
      t.references :position, index: true, foreign_key: true
    end
  end
end
