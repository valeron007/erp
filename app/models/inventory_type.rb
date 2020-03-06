class InventoryType < ActiveRecord::Base

  default_scope { order('LOWER(name) ASC') }

  def self.search(query)
    where("LOWER(name) LIKE ?", "%#{query.downcase}%")
  end

  def to_s
    name
  end

  def to_label
    to_s
  end

end
