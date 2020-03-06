class WorkTypeTool < ActiveRecord::Base
  belongs_to :work_type
  belongs_to :tool

  validates :work_type, :tool, presence: true

  def to_s
    tool.to_s
  end
end
