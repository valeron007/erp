class FacilityAdditional < ActiveRecord::Base
  belongs_to :facility
  belongs_to :additional
  default_scope { joins(:additional).order('LOWER(additionals.name) ASC') }
end
