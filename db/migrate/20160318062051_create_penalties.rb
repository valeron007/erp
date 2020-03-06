class CreatePenalties < ActiveRecord::Migration
  def change
    create_table :penalties do |t|
      t.string :name
      t.float :penalty_rate

      t.timestamps null: false
    end
  end
end
