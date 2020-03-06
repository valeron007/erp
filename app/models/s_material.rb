class SMaterial < ActiveRecord::Base
  belongs_to :name, class_name: "Material"
  belongs_to :unit

  has_many :s_transaction_material

  validates :name, presence: true

  mount_uploaders :s_material_files, SMaterialUploader
  serialize :s_material_files, JSON

  before_validation :format_amount

  self.per_page = 10

  def with_unit
    "#{name.to_s}"
  end

  scope :required_order, -> {
    where('amount < min_amount and min_amount is not null');
  }

  filterrific(
      default_filter_params: { sorted_by: 'name_desc' },
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
    joins(:name).where(
        terms.map { |term|
          "(LOWER(materials.name) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^name/
        joins(:name).order("LOWER(materials.name) #{ direction }")
      when /^pack/
        order("LOWER(pack) #{ direction }")
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
      where('LOWER(s_materials.storage_place) = ?', terms)
    end
  }

  scope :without_null, lambda { |flag|
    return nil if 0 == flag
    where("amount > 0")
  }

  def self.options_for_select
    joins(:name).order('LOWER(materials.name)').map { |e| [e.with_unit, e.id] }
  end

  def self.options_for_select_storage_place
    pluck(:storage_place).map { |place| place.downcase}.uniq.sort.map { |e| [e, e] }
  end

  private

  def format_amount
    self.amount = self.attributes_before_type_cast["amount"].to_s.gsub(",", ".").to_f
  end
end
