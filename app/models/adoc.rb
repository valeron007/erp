class Adoc < ActiveRecord::Base
  belongs_to :facility, inverse_of: :adocs
  belongs_to :adoc_name
  belongs_to :adoc_status
  default_scope { order('index_number ASC') }
end
