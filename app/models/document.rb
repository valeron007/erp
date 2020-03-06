class Document < ActiveRecord::Base
  attr_accessor :sheet_content

  has_paper_trail
  belongs_to :created_by, class_name: "User"
  belongs_to :updated_by, class_name: "User"

  enum document_type: [:text, :sheet]

  scope :for_user, lambda{ |user| where("roles LIKE '%#{user.role}%'") unless user.admin_role? }

  before_save :clean_data
  before_save :set_sheet_content

  private
    def clean_data
      self.content = self.content.gsub(/ style=\"max-width:320px;margin:auto;\"/, '')
    end

    def set_sheet_content
      self.content = sheet_content if sheet?
    end
end
