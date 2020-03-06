class WorkTypeMaterial < ActiveRecord::Base
  belongs_to :work_type
  belongs_to :material

  validates :work_type, :material, presence: true

  def to_s
    material.to_s
  end
end
