class CreateDNames < ActiveRecord::Migration
  def change
    create_table :d_names do |t|
      t.string :name
      t.decimal :price, :precision => 16, :scale => 2

      t.timestamps null: false
    end
  end
end
