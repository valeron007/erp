class CreateKpis < ActiveRecord::Migration
  def change
    create_table :kpis do |t|
      t.string :name
      t.float :weight
      t.float :norm

      t.timestamps null: false
    end
  end
end
