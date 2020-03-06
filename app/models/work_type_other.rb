class WorkTypeOther < ActiveRecord::Base
  belongs_to :work_type
  belongs_to :other

  validates :work_type, :other, presence: true

  def to_s
    other.to_s
  end
end
