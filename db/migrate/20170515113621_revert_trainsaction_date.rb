class RevertTrainsactionDate < ActiveRecord::Migration
  def change
    change_column :s_transactions, :date, :date
  end
end
