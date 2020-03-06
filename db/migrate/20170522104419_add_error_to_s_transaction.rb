class AddErrorToSTransaction < ActiveRecord::Migration
  def change
    add_column :s_transactions, :error_text, :text
  end
end
