class FacilityNote < ActiveRecord::Base
  belongs_to :facility
  belongs_to :user

  default_scope { order('created_at DESC') }
end
