class PaymentType < ActiveRecord::Base
  validates :name, presence: true

  TYPE_PIECEWORK = 1
  TYPE_SALARY = 2


  default_scope { order('LOWER(name) ASC') }

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
