class AddAdditionalFilesToEmployee < ActiveRecord::Migration
  def up
    add_attachment :employees, :additional_document_1
    add_attachment :employees, :additional_document_2
    add_attachment :employees, :additional_document_3
  end

  def down
    remove_attachment :employees, :additional_document_1
    remove_attachment :employees, :additional_document_2
    remove_attachment :employees, :additional_document_3
  end
end
