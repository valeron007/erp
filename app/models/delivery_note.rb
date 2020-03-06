class DeliveryNote < ActiveRecord::Base
  belongs_to :delivery
  belongs_to :user

  default_scope { order('created_at DESC') }
end
