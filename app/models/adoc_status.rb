class AdocStatus < ActiveRecord::Base

  default_scope { order('`order` ASC') }

  def to_s
    name
  end

  def to_label
    to_s
  end
end
