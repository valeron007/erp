class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.references :position, index: true, foreign_key: true
      t.date :hire_date
      t.integer :probation_period
      t.references :employee_status, index: true, foreign_key: true
      t.date :fire_date
      t.references :fire_reason, index: true, foreign_key: true
      t.string :passport
      t.date :birth_date
      t.string :citizenship
      t.string :nationality
      t.boolean :felony
      t.text :felony_notes
      t.float :salary
      t.float :salary_ratio
      t.string :card_number
      t.string :card_owner
      t.string :shoes_size
      t.string :dress_size
      t.string :height
      t.integer :children_count
      t.string :mobile_number
      t.string :phone_number
      t.string :address
      t.string :residential_address
      t.string :emergency_name
      t.string :emergency_phone

      t.timestamps null: false
    end
  end
end
