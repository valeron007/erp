class CreateSTools < ActiveRecord::Migration
  def change
    create_table :s_tools do |t|
      t.string :description
      t.float :amount
      t.string :serial_number
      t.string :rfid_tag
      t.string :barcode_tag
      t.string :consist
      t.float :min_amount
      t.string :storage_place
      t.string :state
      t.text :comments
      t.text :photos

      t.timestamps null: false
    end
    add_column :s_tools, :name_id, :integer
    add_index :s_tools, :name_id
    add_foreign_key :s_tools, :tools, column: :name_id
  end
end
