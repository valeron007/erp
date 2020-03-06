class CreateContactsLeads < ActiveRecord::Migration
  def change
    create_table :contacts_leads do |t|
      t.references :lead, index: true, foreign_key: true
      t.references :contact, index: true, foreign_key: true
    end
  end
end
