class WorkTypeCategory < ActiveRecord::Base
  belongs_to :work_category
  belongs_to :work_type
end
