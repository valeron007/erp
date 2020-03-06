class DName < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  def to_s
    "#{name} / #{number_to_currency(price)}"
  end

  def to_label
    to_s
  end

  def self.options_for_select_name
    pluck(:name).uniq.sort.map { |e| [e, e] }
  end

end
