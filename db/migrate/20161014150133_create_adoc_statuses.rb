class CreateAdocStatuses < ActiveRecord::Migration
  def change
    create_table :adoc_statuses do |t|
      t.string :name
      t.string :color
      t.integer :order

      t.timestamps null: false
    end
  end
end
