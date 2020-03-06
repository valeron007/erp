class FacilityStatus < ActiveRecord::Base
  validates :name, presence: true

  default_scope { order('id ASC') }

  DRAFT = 1
  OPEN = 2
  CLOSE = 3
  REOPEN = 4

  def self.draft
    find_by_id(DRAFT)
  end

  def self.open
    find_by_id(OPEN)
  end

  def self.close
    find_by_id(CLOSE)
  end

  def self.close_id
    CLOSE
  end

  def self.reopen
    find_by_id(REOPEN)
  end

  def closed?
    id == CLOSE
  end
  def closeable?
    id == DRAFT or id == OPEN or id == REOPEN
  end

  def self.options_for_select
    order('id ASC')
  end

  def self.options_for_name_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

  def to_s
    name
  end

  def to_label
    to_s
  end


end
