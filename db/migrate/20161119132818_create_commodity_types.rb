class CreateCommodityTypes < ActiveRecord::Migration
  def change
    create_table :commodity_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
