class ExpenseCategory < ActiveRecord::Base
  def to_s
    name
  end

  def to_label
    to_s
  end

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
