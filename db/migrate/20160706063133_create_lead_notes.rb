class CreateLeadNotes < ActiveRecord::Migration
  def change
    create_table :lead_notes do |t|
      t.references :lead, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :val

      t.timestamps null: false
    end
  end
end
