class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.text :content
      t.integer :created_by_id, index:true
      t.integer :updated_by_id, index:true
      t.timestamps null: false
    end

    add_foreign_key :documents, :users, column: :created_by_id
    add_foreign_key :documents, :users, column: :updated_by_id

  end
end
