class AddDocumentNumberToSTransactions < ActiveRecord::Migration
  def change
    add_column :s_transactions, :document_number, :string
  end
end
