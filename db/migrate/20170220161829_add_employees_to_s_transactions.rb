class AddEmployeesToSTransactions < ActiveRecord::Migration
  def change
    remove_foreign_key :s_transactions, name: "fk_rails_b01f8050c8"
    add_foreign_key :s_transactions, :employees, column: :user_from_id
    remove_foreign_key :s_transactions, name: "fk_rails_39f98ea296"
    add_foreign_key :s_transactions, :employees, column: :user_to_id
  end
end
