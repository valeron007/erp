class AddDeletedAtToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :deleted_at, :datetime
    add_index :leads, :deleted_at
  end
end
