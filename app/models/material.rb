# encoding: UTF-8
class Material < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :inventory_type
  belongs_to :unit

  validates :name, :unit, presence: true
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :work_type_materials, inverse_of: :material

  has_and_belongs_to_many :d_names, join_table: "d_names_materials"
  accepts_nested_attributes_for :d_names, reject_if: :all_blank, allow_destroy: true

  before_save :update_price

  default_scope { order('LOWER(materials.name) ASC') }

  def self.search(query)
    joins("LEFT JOIN d_names_materials ON d_names_materials.material_id = materials.id LEFT JOIN d_names ON d_names_materials.d_name_id = d_names.id")
    .where("LOWER(materials.name) LIKE :q OR LOWER(materials.tags) LIKE :q OR LOWER(d_names.name) LIKE :q", q: "%#{query.downcase}%")
  end

  def to_s
    "#{name_with_aliases} (#{number_to_currency(price_per_unit)}/#{unit})"
  end

  def name_with_aliases
    if tags.nil? or tags.blank?
      name
    else
      JSON.parse(tags).reject { |r| r.blank? }.unshift(name).join(' / ')
    end
  end

  def alias_names
    if tags.nil? or tags.blank?
      name
    else
      JSON.parse(tags).reject { |r| r.blank? }.join(' / ')
    end
  end

  def price_to_s
    "#{number_to_currency(price_per_unit)}/#{unit}"
  end

  def to_label
    to_s
  end

  def update_price
    self.price_per_unit = self.d_names.last.price unless self.d_names.blank?
  end

  def self.options_for_select_name
    pluck(:name).uniq.sort.map { |e| [e, e] }
  end

  def self.names
    pluck(:name)
  end
  def self.tags
    pluck(:tags)
  end

  def self.options_for_select_alias_name
    names = self.names.reject{|r| r.nil?}.flatten.uniq.reject { |r| r.blank? }
    tags = self.tags.reject{|r| r.nil?}.flatten.map {|r| JSON.parse(r)}.flatten.uniq.reject { |r| r.blank? }
    names.concat(tags).uniq.sort.map { |e| [e, e] }
  end

  def self.options_for_select_document_name
    reorder(nil).order('lower(document_name) ASC').distinct.pluck(:document_name).map { |e| [e, e] }
  end

end
