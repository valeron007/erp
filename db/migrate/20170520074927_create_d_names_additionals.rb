class CreateDNamesAdditionals < ActiveRecord::Migration
  def change
    create_table :d_names_additionals do |t|
      t.references :d_name, index: true, foreign_key: true
      t.references :additional, index: true, foreign_key: true
    end
  end
end
