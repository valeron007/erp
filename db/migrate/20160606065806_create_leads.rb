class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :name
      t.string :short_name
      t.references :client, index: true, foreign_key: true
      t.string :address
      t.date :visit_date
      t.references :lead_status, index: true, foreign_key: true
      t.references :lead_type, index: true, foreign_key: true
      t.references :lead_construction_type, index: true, foreign_key: true
      t.boolean :project
      t.string :project_institute
      t.string :gip
      t.string :gip_phone
      t.string :gap
      t.string :gap_phone
      t.boolean :project_help
      t.text :details
      t.text :representatives
      t.boolean :psycho01
      t.boolean :psycho02
      t.boolean :psycho03
      t.boolean :psycho04
      t.boolean :psycho05
      t.boolean :psycho06
      t.boolean :psycho07
      t.boolean :psycho08
      t.boolean :psycho09
      t.boolean :psycho10
      t.boolean :psycho11
      t.boolean :psycho12
      t.boolean :psycho13
      t.text :psycho_other
      t.decimal :sum_contract
      t.references :lead_payment_status, index: true, foreign_key: true
      t.decimal :sum_payment
      t.decimal :debt
      t.string :credit
      t.date :next_date

      t.timestamps null: false
    end
  end
end
