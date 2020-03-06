class RemoveMetricFromWorkType < ActiveRecord::Migration
  def change
    remove_column :work_types, :metric
  end
end
