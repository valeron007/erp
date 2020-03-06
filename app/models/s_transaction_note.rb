class STransactionNote < ActiveRecord::Base
  belongs_to :s_transaction
  belongs_to :user
end
