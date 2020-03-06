class CreateLeadConstructionTypesLeads < ActiveRecord::Migration
  def change
    create_table :lead_construction_types_leads, id: false do |t|
      t.belongs_to :lead_construction_type, index: true
      t.belongs_to :lead, index: true
    end
  end
end
