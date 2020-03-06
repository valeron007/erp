# == Schema Information
#
# Table name: positions
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Position < ActiveRecord::Base
  validates :name, presence: true

  default_scope { order('LOWER(name) ASC') }

  WORKER = 3

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
