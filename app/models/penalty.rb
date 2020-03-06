class Penalty < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  has_many :daily_timesheet_penalty
  has_many :employees

  validates :name, :penalty_rate, presence: true

  default_scope { order('LOWER(name) ASC') }

  def to_s
    "#{name} (#{number_to_currency(penalty_rate)})"
  end

  def to_label
    to_s
  end
end
