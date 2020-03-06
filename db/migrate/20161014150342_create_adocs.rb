class CreateAdocs < ActiveRecord::Migration
  def change
    create_table :adocs do |t|
      t.references :adoc_name, index: true, foreign_key: true
      t.string :number
      t.date :date
      t.boolean :present
      t.decimal :amount
      t.references :adoc_status, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
