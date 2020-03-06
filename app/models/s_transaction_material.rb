class STransactionMaterial < ActiveRecord::Base
  belongs_to :s_material
  belongs_to :s_transaction

  def total_price
    price = 0
    unless s_material.name.price_per_unit.nil?
      price = s_amount * s_material.name.price_per_unit
    end
    price
  end

  def update_amount(mode)
    type = self.s_transaction.operation_type
    self.s_material.amount = 0 if self.s_material.amount.nil?
    if mode == :destroy
      if type == 'income' or type == 'entrance'
        self.s_material.amount -= self.s_amount
      elsif type == 'outcome' or type == 'exit'
        self.s_material.amount += self.s_amount
      end
    else
      amount = 0
      amount = self.s_amount_was if self.s_amount_was
      if type == 'income' or type == 'entrance'
        self.s_material.amount += (self.s_amount - amount)
      elsif type == 'outcome' or type == 'exit'
        self.s_material.amount -= (self.s_amount - amount)
      end
    end
    self.s_material.save
  end

end
