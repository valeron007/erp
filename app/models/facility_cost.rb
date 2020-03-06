class FacilityCost < ActiveRecord::Base
  belongs_to :facility
  default_scope { order('LOWER(title) ASC') }
end
