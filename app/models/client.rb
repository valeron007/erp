class Client < ActiveRecord::Base

  include ApplicationHelper

  has_many :leads

  validates :name, presence: true

  self.per_page = 10

  filterrific(
      default_filter_params: { sorted_by: 'name_asc' },
      available_filters: [
          :sorted_by,
          :search_query,
      ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    terms = query.to_s.mb_chars.downcase.split(/\s+/)

    terms = terms.map { |e|
      ('%' + e + '%').gsub(/%+/, '%')
    }
    num_or_conds = 3
    joins(:leads).where(
        terms.map { |term|
          "(LOWER(clients.name) LIKE ? OR LOWER(leads.name) LIKE ? OR LOWER(leads.short_name) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^name/
        order("LOWER(clients.name) #{ direction }")
      when /^address/
        order("LOWER(clients.address) #{ direction }")
      when /^phone/
        order("LOWER(clients.phone) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.search_by_phone(phone)
    where("phone LIKE ?", "%#{phone}%")
  end

  def managers
    leads.map {|h| h.created_by unless h.created_by.blank?}.uniq.join(',')
  end

  def last_visit_date
    leads.map {|h| h_localize_date(h.visit_date) unless h.visit_date.blank?}.uniq.join(', ')
  end

  def next_visit_date
    leads.map {|h| h_localize_date(h.next_date) unless h.next_date.blank?}.uniq.join(', ')
  end

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

  def to_s
    name
  end

  def to_label
    to_s
  end
end
