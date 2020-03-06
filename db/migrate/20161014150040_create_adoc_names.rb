class CreateAdocNames < ActiveRecord::Migration
  def change
    create_table :adoc_names do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
