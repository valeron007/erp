class CreateWorkTypeCategories < ActiveRecord::Migration
  def change
    create_table :work_type_categories do |t|
      t.references :work_category, index: true, foreign_key: true
      t.references :work_type, index: true, foreign_key: true
      t.float :amount

      t.timestamps null: false
    end
  end
end
