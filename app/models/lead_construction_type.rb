class LeadConstructionType < ActiveRecord::Base
  has_and_belongs_to_many :leads

  def to_s
    name
  end

  def to_label
    to_s
  end
end
