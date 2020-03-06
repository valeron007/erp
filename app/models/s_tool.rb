class STool < ActiveRecord::Base
  belongs_to :name, class_name: "Tool"
  belongs_to :facility
  has_many :s_transaction_tool
  has_many :s_transactions, through: :s_transaction_tool

  validates :name, presence: true

  mount_uploaders :s_tool_files, SToolUploader
  serialize :s_tool_files, JSON

  self.per_page = 10

  before_update :update_tool_location

  def update_tool_location
    self.facility = self.get_current_location
  end
  
  def with_inventory_consist
    full_name = name.to_s
    full_name += inventory_number.to_s.strip.empty? ? "" : " / #{inventory_number}"
    full_name += consist.to_s.strip.empty? ? "" : " (#{consist})"
    full_name
  end

  def with_inventory_number
    full_name = name.name_with_aliases
    full_name += inventory_number.to_s.strip.empty? ? "" : " / #{inventory_number}"
    full_name
  end

  def get_current_location
    self.s_transactions.empty? ? nil : self.s_transactions.order("s_transactions.date DESC, s_transactions.updated_at DESC").first.destination
  end

  def location_as_string
    get_current_location ? get_current_location.to_s : "Склад"
  end

  def get_transactions
    self.s_transactions.order('s_transactions.date DESC, s_transactions.updated_at DESC')
  end

  filterrific(
      default_filter_params: { sorted_by: 'name_desc', with_trashed: 0 },
      available_filters: [
          :sorted_by,
          :state,
          :current_location,
          :search_query,
          :with_storage_place,
          :with_trashed
      ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    terms = query.to_s.mb_chars.downcase.split(/\s+/)

    terms = terms.map { |e|
      ('%' + e + '%').gsub(/%+/, '%')
    }
    num_or_conds = 2
    joins(:name).where(
        terms.map { |term|
          "(LOWER(tools.name) LIKE ? or LOWER(s_tools.inventory_number) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^name/
        joins(:name).order("LOWER(tools.name) #{ direction }")
      when /^inventory_number/
        order("LOWER(inventory_number) #{ direction }")
      when /^state/
        order("LOWER(state) #{ direction }")
      when /^storage_place/
        order("LOWER(storage_place) #{ direction }")
      when /^location/
        joins('LEFT OUTER JOIN `facilities` ON `facilities`.`id` = `s_tools`.`facility_id`').order("LOWER(facilities.name) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_storage_place, lambda { |place|
    unless place.blank?
      terms = place.to_s.mb_chars.downcase
      where('LOWER(s_tools.storage_place) = ?', terms)
    end
  }
  scope :current_location, lambda { |location|
    where('facility_id = ?', location).distinct unless location.blank?
  }
  scope :with_trashed, lambda { |value|
    value == 1 ? all : where(trashed: false)
  }
  scope :state, lambda { |state|
    where('s_tools.state = ?', state) unless state.blank?
  }

  def self.options_for_select
    joins(:name).order('LOWER(tools.name)').map { |e| [e.with_inventory_consist, e.id] }
  end

  def self.options_for_select_storage_place
    pluck(:storage_place).map { |place| place.downcase}.uniq.sort.map { |e| [e, e] }
  end
end
