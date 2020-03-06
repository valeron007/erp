class SAdditional < ActiveRecord::Base
  belongs_to :additional
  belongs_to :unit

  has_many :s_transaction_additional

  validates :additional, presence: true

  mount_uploaders :s_additional_files, SAdditionalUploader
  serialize :s_additional_files, JSON

  self.per_page = 10

  def with_unit
    "#{additional.to_s}"
  end

  scope :required_order, -> {
    where('amount < min_amount and min_amount is not null');
  }

  filterrific(
      default_filter_params: { sorted_by: 'additional_desc' },
      available_filters: [
          :sorted_by,
          :search_query,
          :with_storage_place,
          :without_null
      ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    terms = query.to_s.mb_chars.downcase.split(/\s+/)

    terms = terms.map { |e|
      ('%' + e + '%').gsub(/%+/, '%')
    }
    num_or_conds = 1
    joins(:additional).where(
        terms.map { |term|
          "(LOWER(additionals.name) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^additional/
        joins(:additional).order("LOWER(additionals.name) #{ direction }")
      when /^amount/
        order("LOWER(amount) #{ direction }")
      when /^unit/
        joins(:unit).order("LOWER(units.name) #{ direction }")
      when /^min_amount/
        order("LOWER(min_amount) #{ direction }")
      when /^storage_place/
        order("LOWER(storage_place) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  scope :with_storage_place, lambda { |place|
    unless place.blank?
      terms = place.to_s.mb_chars.downcase
      where('LOWER(s_additionals.storage_place) = ?', terms)
    end
  }
  scope :without_null, lambda { |flag|
    return nil if 0 == flag
    where("amount > 0")
  }

  def self.options_for_select
    joins(:additional).order('LOWER(additionals.name)').map { |e| [e.with_unit, e.id] }
  end

  def self.options_for_select_storage_place
    pluck(:storage_place).map { |place| place.downcase}.uniq.sort.map { |e| [e, e] }
  end
end
