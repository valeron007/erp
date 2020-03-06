class LeadType < ActiveRecord::Base
  def to_s
    name
  end

  def to_label
    to_s
  end
end
