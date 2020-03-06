class CreateSAdditionals < ActiveRecord::Migration
  def change
    create_table :s_additionals do |t|
      t.references :additional, index: true, foreign_key: true
      t.float :amount
      t.references :unit, index: true, foreign_key: true
      t.float :min_amount
      t.string :storage_place
      t.text :comments
      t.text :s_additional_files

      t.timestamps null: false
    end
  end
end
