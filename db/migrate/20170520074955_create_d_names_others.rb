class CreateDNamesOthers < ActiveRecord::Migration
  def change
    create_table :d_names_others do |t|
      t.references :d_name, index: true, foreign_key: true
      t.references :other, index: true, foreign_key: true
    end
  end
end
