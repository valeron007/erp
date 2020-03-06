class EmployeeNote < ActiveRecord::Base
  belongs_to :employee
  belongs_to :user

  default_scope { order('created_at DESC') }

end
