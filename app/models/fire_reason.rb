class FireReason < ActiveRecord::Base
  validates :name, presence: true

  default_scope { order('LOWER(name) ASC') }

  def to_s
    name
  end

  def to_label
    to_s
  end
end
