class FacilityMaterial < ActiveRecord::Base
  belongs_to :facility
  belongs_to :material
  default_scope { joins(:material).order('LOWER(materials.name) ASC') }
end
