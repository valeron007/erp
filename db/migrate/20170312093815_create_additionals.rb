class CreateAdditionals < ActiveRecord::Migration
  def change
    create_table :additionals do |t|
      t.string :name
      t.references :unit, index: true, foreign_key: true
      t.decimal :price_per_unit, :precision => 16, :scale => 2

      t.timestamps null: false
    end
  end
end
