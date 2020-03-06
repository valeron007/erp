class AddOwnersToLead < ActiveRecord::Migration
  def change
    add_column :leads, :created_by_id, :integer
    add_index :leads, :created_by_id
    add_foreign_key :leads, :users, column: :created_by_id

    add_column :leads, :updated_by_id, :integer
    add_index :leads, :updated_by_id
    add_foreign_key :leads, :users, column: :updated_by_id
  end
end
