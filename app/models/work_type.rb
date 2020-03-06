class WorkType < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :unit
  belongs_to :facility, -> { with_deleted }

  has_many :daily_timesheet_work_types
  has_many :daily_timesheets, through: :daily_timesheet_work_types

  has_many :work_type_tools, inverse_of: :work_type
  has_many :work_type_materials, inverse_of: :work_type
  has_many :work_type_others, inverse_of: :work_type
  has_many :work_type_additionals, inverse_of: :work_type
  has_many :work_type_categories
  has_many :work_categories, through: :work_type_categories

  validates :name, :unit, :price_per_unit, presence: true

  accepts_nested_attributes_for :work_type_tools, :work_type_materials, :work_type_others, :work_type_additionals, reject_if: :all_blank, allow_destroy: true

  # default_scope { order('LOWER(name) ASC') }

  self.per_page = 10

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    joins(:work_categories)
    .where("LOWER(work_types.name) LIKE ? OR CAST(work_types.price_per_unit AS CHAR) = ? OR LOWER(work_categories.name) LIKE ?", "%#{query.downcase}%", query, "%#{query.downcase}%")
    .distinct
  }

  filterrific(
      available_filters: [
          :search_query
      ]
  )

  def to_s
    "#{name} (#{number_to_currency(price_per_unit)}/#{unit})"
  end

  def to_label
    to_s
  end

  def work_categories_list
    work_categories.pluck(:name).join(", ")
  end
end
