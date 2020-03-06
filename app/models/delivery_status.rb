class DeliveryStatus < ActiveRecord::Base
  default_scope { order(order_number: :asc) }
  FINISHED = 8

  def to_s
    name
  end

  def to_label
    to_s
  end
  def self.options_for_select
    pluck(:name, :id)
  end

  def self.finished_id
    FINISHED
  end
end
