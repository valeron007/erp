class AddErrorToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :error_text, :text
  end
end
