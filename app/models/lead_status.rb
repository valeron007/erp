class LeadStatus < ActiveRecord::Base

  FACILITY_CREATED = 9
  CLOSED = 15

  def self.closed_id
    CLOSED
  end

  def create_facility?
    self.id >= FACILITY_CREATED
  end

  def self.options_for_select
    order('id').map { |e| [e.name, e.id] }
  end

  def to_s
    name
  end

  def to_label
    to_s
  end
end
