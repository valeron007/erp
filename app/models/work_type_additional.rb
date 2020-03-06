class WorkTypeAdditional < ActiveRecord::Base
  belongs_to :work_type
  belongs_to :additional

  validates :work_type, :additional, presence: true

  def to_s
    additional.to_s
  end
end
