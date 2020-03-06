class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :title
      t.decimal :amount
      t.string :company
      t.string :facility
      t.references :expense_category, index: true, foreign_key: true
      t.date :expense_date

      t.timestamps null: false
    end
  end
end
