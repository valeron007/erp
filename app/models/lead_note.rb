class LeadNote < ActiveRecord::Base
  belongs_to :lead
  belongs_to :user

  default_scope { order('created_at DESC') }
end
