class RemoveWorkCategoryFromWorkType < ActiveRecord::Migration
  def change
    remove_foreign_key :work_types, :work_category
    remove_reference :work_types, :work_category, index: true
  end
end
