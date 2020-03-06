class CreateEmployeeNotes < ActiveRecord::Migration
  def change
    create_table :employee_notes do |t|
      t.references :employee, index: true, foreign_key: true
      t.text :val

      t.timestamps null: false
    end
  end
end
