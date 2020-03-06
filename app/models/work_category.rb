class WorkCategory < ActiveRecord::Base
  validates :name, presence: true

  has_many :work_type_categories
  has_many :work_types, through: :work_type_categories

  accepts_nested_attributes_for :work_type_categories, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true

  # default_scope { order('LOWER(name) ASC') }

  self.per_page = 10

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    where("LOWER(name) LIKE ?", "%#{query.downcase}%")
  }

  filterrific(
      available_filters: [
          :search_query
      ]
  )

  def to_s
    name
  end

  def to_label
    to_s
  end
end
