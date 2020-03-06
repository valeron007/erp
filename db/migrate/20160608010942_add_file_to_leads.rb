class AddFileToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :lead_files, :text
  end
end
