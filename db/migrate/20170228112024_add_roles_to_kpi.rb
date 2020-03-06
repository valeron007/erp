class AddRolesToKpi < ActiveRecord::Migration
  def change
    add_column :kpis, :roles, :string
  end
end
