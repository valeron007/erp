class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :desc
      t.date :assign_date
      t.date :finish_date
      t.references :task_status, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
