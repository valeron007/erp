class Contact < ActiveRecord::Base

  has_and_belongs_to_many :leads

  def to_s
    "#{name} #{phone} (#{position})"
  end

  def to_label
    to_s
  end
end
