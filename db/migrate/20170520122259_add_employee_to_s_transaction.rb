class AddEmployeeToSTransaction < ActiveRecord::Migration
  def change
    add_reference :s_transactions, :employee, index: true, foreign_key: true
  end
end
