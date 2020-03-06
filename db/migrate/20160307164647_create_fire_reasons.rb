class CreateFireReasons < ActiveRecord::Migration
  def change
    create_table :fire_reasons do |t|
      t.string :name
      t.integer :order

      t.timestamps null: false
    end
  end
end
