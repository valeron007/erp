class FacilityWorkType < ActiveRecord::Base
  belongs_to :facility
  belongs_to :work_type
  default_scope { joins(:work_type).order('LOWER(work_types.name) ASC') }
end
