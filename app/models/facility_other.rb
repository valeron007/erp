class FacilityOther < ActiveRecord::Base
  belongs_to :facility
  belongs_to :other
  default_scope { joins(:other).order('LOWER(others.name) ASC') }
end
