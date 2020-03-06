class CreateWorkTypeAdditionals < ActiveRecord::Migration
  def change
    create_table :work_type_additionals do |t|
      t.references :work_type, index: true, foreign_key: true
      t.references :additional, index: true, foreign_key: true
      t.float :amount

      t.timestamps null: false
    end
  end
end
