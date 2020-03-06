class AddPassportsAttachToEmployee < ActiveRecord::Migration
  def up
    add_attachment :employees, :passport_front
    add_attachment :employees, :passport_reg
  end

  def down
    remove_attachment :employees, :passport_front
    remove_attachment :employees, :passport_reg
  end
end
