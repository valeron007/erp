class CreateDailyWorks < ActiveRecord::Migration
  def change
    create_table :daily_works do |t|
      t.date :date
      t.references :user, index: true, foreign_key: true
      t.datetime :deleted_at, index: true

      t.timestamps null: false
    end
  end
end
