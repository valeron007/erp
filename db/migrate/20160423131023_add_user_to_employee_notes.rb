class AddUserToEmployeeNotes < ActiveRecord::Migration
  def change
    add_reference :employee_notes, :user, index: true, foreign_key: true
  end
end
