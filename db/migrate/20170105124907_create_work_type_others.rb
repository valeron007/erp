class CreateWorkTypeOthers < ActiveRecord::Migration
  def change
    create_table :work_type_others do |t|
      t.references :work_type, index: true, foreign_key: true
      t.references :other, index: true, foreign_key: true
      t.float :amount

      t.timestamps null: false
    end
  end
end
