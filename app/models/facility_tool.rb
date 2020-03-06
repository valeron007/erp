class FacilityTool < ActiveRecord::Base
  belongs_to :facility
  belongs_to :tool
  default_scope { joins(:tool).order('LOWER(tools.name) ASC') }
end
