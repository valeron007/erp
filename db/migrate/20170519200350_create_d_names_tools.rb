class CreateDNamesTools < ActiveRecord::Migration
  def change
    create_table :d_names_tools do |t|
      t.references :d_name, index: true, foreign_key: true
      t.references :tool, index: true, foreign_key: true
    end
  end
end
