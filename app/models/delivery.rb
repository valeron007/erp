# encoding: UTF-8
class Delivery < ActiveRecord::Base
  belongs_to :unit
  belongs_to :volume_unit, class_name: "Unit"
  belongs_to :contractor
  belongs_to :transport_company
  belongs_to :delivery_payment_status
  belongs_to :delivery_status
  belongs_to :delivery_document
  belongs_to :delivery_letter
  belongs_to :delivery_dest
  belongs_to :commodity_type

  has_many :delivery_notes

  validates :name, :count, :unit, :cost, :price_per_unit, :order_date, :delivery_status, presence: true

  self.per_page = 10

  def self.autocomplete_name(query)
    query.length >= 3 ? where("LOWER(name) LIKE ?", "%#{query.downcase}%").limit(10).pluck(:name) : []
  end

  def to_s
    name
  end
  scope :not_finished_deliveries, -> {
    joins(:delivery_status).where('delivery_statuses.order_number < ?', DeliveryStatus.finished_id)
  }

  scope :arrival_date_gte, lambda { |reference_time|
    where('deliveries.order_date >= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :arrival_date_lt, lambda { |reference_time|
    where('deliveries.order_date <= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    terms = query.to_s.mb_chars.downcase.split(/\s+/)

    terms = terms.map { |e|
      ('%' + e + '%').gsub(/%+/, '%')
    }
    num_or_conds = 1
    where(
        terms.map { |term|
          "(LOWER(deliveries.name) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  filterrific(
      default_filter_params: { sorted_by: 'name_desc' },
      available_filters: [
          :sorted_by,
          :search_query,
          :with_delivery_status_id,
          :with_contractor_id,
          :arrival_date_gte,
          :arrival_date_lt,
      ]
  )

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^name/
        order("LOWER(deliveries.name) #{ direction }")
      when /^arrival_date/
        order("deliveries.arrival_date #{ direction }")
      when /^delivery_status/
        joins(:delivery_status).order("LOWER(delivery_statuses.name) #{ direction }")
      when /^delivery_payment_status/
        joins(:delivery_payment_status).order("LOWER(delivery_payment_statuses.name) #{ direction }")
      when /^contractor/
        joins(:contractor).order("LOWER(contractors.name) #{ direction }")
      when /^order_date/
        order("deliveries.order_date #{ direction }")
      when /^update_date/
        order("deliveries.updated_at #{ direction }")
      when /^count/
        order("deliveries.count #{ direction }")
      when /^price_per_unit/
        order("deliveries.price_per_unit #{ direction }")
      when /^cost/
        order("deliveries.cost #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :arrival_date, lambda { |reference_time|
    where('deliveries.arrival_date = ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :with_delivery_status_id, lambda { |delivery_status_ids|
    where(delivery_status_id: [*delivery_status_ids])
  }

  scope :with_contractor_id, lambda { |contractor_ids|
    where(contractor_id: [*contractor_ids])
  }
end
