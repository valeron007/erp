class AddSourceToTransaction < ActiveRecord::Migration
  def change
    add_reference :s_transactions, :source, index: true
    add_foreign_key :s_transactions, :facilities, column: :source_id
  end
end
