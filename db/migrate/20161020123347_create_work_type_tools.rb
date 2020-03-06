class CreateWorkTypeTools < ActiveRecord::Migration
  def change
    create_table :work_type_tools do |t|
      t.references :work_type, index: true, foreign_key: true
      t.references :tool, index: true, foreign_key: true
      t.float :amount

      t.timestamps null: false
    end
  end
end
