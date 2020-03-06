class CreateLeadConstructionTypes < ActiveRecord::Migration
  def change
    create_table :lead_construction_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
