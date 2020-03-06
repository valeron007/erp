class Unit < ActiveRecord::Base
  validates :name, presence: true

  def to_s
    name
  end

  def to_label
    to_s
  end
end
