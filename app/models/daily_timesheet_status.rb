class DailyTimesheetStatus < ActiveRecord::Base
  validates :name, presence: true

  default_scope { order('LOWER(name) ASC') }

  DRAFT = 1

  def self.draft
    find_by_id(DRAFT)
  end
  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
  
  def to_s
    name
  end

  def to_label
    to_s
  end
end
