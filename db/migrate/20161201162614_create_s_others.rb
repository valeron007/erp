class CreateSOthers < ActiveRecord::Migration
  def change
    create_table :s_others do |t|
      t.float :amount
      t.references :unit, index: true, foreign_key: true
      t.float :min_amount
      t.string :storage_place
      t.text :comments

      t.timestamps null: false
    end
    add_column :s_others, :name_id, :integer
    add_index :s_others, :name_id
    add_foreign_key :s_others, :others, column: :name_id
  end
end
