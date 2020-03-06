class RemoveLeadContructionTypeRefFromLead < ActiveRecord::Migration
  def change
    remove_reference :leads, :lead_construction_type, index: true, foreign_key: true
  end
end
