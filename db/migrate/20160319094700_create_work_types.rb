class CreateWorkTypes < ActiveRecord::Migration
  def change
    create_table :work_types do |t|
      t.string :name
      t.string :metric
      t.float :price
      t.references :facility, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
