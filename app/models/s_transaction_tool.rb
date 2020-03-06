class STransactionTool < ActiveRecord::Base
  belongs_to :s_tool
  belongs_to :s_transaction
  validate :tool_source_should_equals_its_location

  def total_price
    price = 0
    unless s_tool.name.price_per_unit.nil?
      price = s_tool.name.price_per_unit
    end
    price
  end

  def tool_source_should_equals_its_location
    if s_tool.get_current_location != s_transaction.source
      s_transaction.errors.add(:source, :should_equals_current_location)
      s_transaction.errors.add(:s_transaction_tools, :wrong_location)
    end
  end
end
