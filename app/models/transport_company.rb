class TransportCompany < ActiveRecord::Base
  has_many :deliveries
  mount_uploaders :transport_company_files, TransportCompanyUploader
  serialize :transport_company_files, JSON
  
  self.per_page = 10

  def to_s
    name
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
          "(LOWER(transport_companies.name) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^name/
        order("LOWER(transport_companies.name) #{ direction }")
      when /^phone/
        order("transport_companies.phone #{ direction }")
      when /^email/
        order("transport_companies.email #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

end
