class AddWorkCategoryToWorkType < ActiveRecord::Migration
  def change
    add_reference :work_types, :work_category, index: true, foreign_key: true
  end
end
