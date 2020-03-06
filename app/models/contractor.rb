class Contractor < ActiveRecord::Base
  has_many :deliveries

  mount_uploaders :contractor_files, ContractorUploader
  serialize :contractor_files, JSON

  self.per_page = 10

  def to_s
    name
  end

  def self.options_for_select
    order('id ASC').map { |e| [e.name, e.id] }
  end

  def self.search_by_phone(phone)
    where("phone LIKE ?", "%#{phone}%")
  end
  
  filterrific(
      default_filter_params: { sorted_by: 'name_desc' },
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
    num_or_conds = 1
    where(
      terms.map { |term|
        "(LOWER(contractors.name) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^name/
        order("LOWER(contractors.name) #{ direction }")
      when /^phone/
        order("contractors.phone #{ direction }")
      when /^email/
        order("contractors.email #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

end
