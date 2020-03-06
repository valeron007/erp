class EmployeeStatus < ActiveRecord::Base
  validates :name, presence: true

  default_scope { order('LOWER(name) ASC') }

  ACTIVE = 2

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

  def self.active
    find_by_id(ACTIVE)
  end

  def to_s
    name
  end

  def to_label
    to_s
  end
end
