class STransaction < ActiveRecord::Base

  acts_as_paranoid

  validates :date, :operation_type, presence: true

  attr_accessor :current_user

  belongs_to :destination, class_name: :Facility
  belongs_to :source, class_name: :Facility
  belongs_to :user_from, class_name: :Employee
  belongs_to :driver, class_name: :Employee
  belongs_to :user_to, class_name: :Employee
  belongs_to :employee, class_name: :Employee

  has_many :s_transaction_materials, inverse_of: :s_transaction
  accepts_nested_attributes_for :s_transaction_materials, reject_if: :all_blank, allow_destroy: true
  has_many :s_transaction_tools, inverse_of: :s_transaction
  accepts_nested_attributes_for :s_transaction_tools, reject_if: :all_blank, allow_destroy: true
  has_many :s_transaction_others, inverse_of: :s_transaction
  accepts_nested_attributes_for :s_transaction_others, reject_if: :all_blank, allow_destroy: true
  has_many :s_transaction_additionals, inverse_of: :s_transaction
  accepts_nested_attributes_for :s_transaction_additionals, reject_if: :all_blank, allow_destroy: true

  has_many :s_transaction_notes

  has_many :s_additionals, through: :s_transaction_additionals
  has_many :s_materials, through: :s_transaction_materials
  has_many :s_others, through: :s_transaction_others
  has_many :s_tools, through: :s_transaction_tools

  before_destroy :delete_related_amounts
  before_create :create_related_amounts
  before_update :update_related_amounts, :related_resources_changed

  after_destroy :update_tools_location
  after_create :update_tools_location
  after_update :update_tools_location

  self.per_page = 10

  def get_source
    if operation_type == 'entrance' and source.blank?
      I18n.t('Default entrance')
    else
      source.blank? ? I18n.t('Default warehouse') : source
    end
  end

  def get_dest
    if operation_type == 'exit' and destination.blank?
      I18n.t('Default exit')
    else
      destination.blank? ? I18n.t('Default warehouse') : destination
    end
  end

  def update_tools_location
    self.s_tools.each do |tool|
      tool.update_tool_location
      if self.operation_type == 'exit'
        tool.trashed = true
      else
        tool.trashed = false
      end
      tool.save
    end
  end

  def delete_related_amounts
    related_amounts(:destroy)
  end
  def create_related_amounts
    related_amounts(:create)
  end
  def update_related_amounts
    related_amounts(:update)
  end

  def related_amounts(mode)
    self.s_transaction_materials.each do |material|
      material.update_amount(mode)
    end
    self.s_transaction_others.each do |other|
      other.update_amount(mode)
    end
    self.s_transaction_additionals.each do |a|
      a.update_amount(mode)
    end
  end

  def related_resources_changed
    whats = Array.new
    tos = Array.new
    froms = Array.new
    self.s_transaction_materials.each do |material|
      whats, froms, tos = generate_note_text(material.s_material.name.name, material, whats, froms, tos)
    end
    self.s_transaction_tools.each do |tool|
      whats, froms, tos = generate_note_text(tool.s_tool.name.name, tool, whats, froms, tos)
    end
    self.s_transaction_others.each do |other|
      whats, froms, tos = generate_note_text(other.s_other.name.name, other, whats, froms, tos)
    end
    self.s_transaction_additionals.each do |a|
      whats, froms, tos = generate_note_text(a.s_additional.additional.name, a, whats, froms, tos)
    end
    create_note(whats, froms, tos)
  end

  def generate_note_text(name, item, whats, froms, tos)
    whats.push(name)
    if item.class.name == "STransactionTool"
      if item._destroy
        froms.push("1")
        tos.push("0")
      else
        froms.push("0")
        tos.push("1")
      end
    else
      if item.changed? and !item.s_amount_was.nil?
        froms.push(item.s_amount_was)
        tos.push(item.s_amount)
      elsif item.s_amount_was.nil? and item.s_amount
        froms.push("0")
        tos.push(item.s_amount)
      elsif item._destroy
        froms.push(item.s_amount_was)
        tos.push("0")
      end
    end
    return whats, froms, tos
  end

  def create_note(what, from, to)
    temp_str = String.new
    @note = STransactionNote.new
    @note.s_transaction = self
    @note.user = self.current_user
    if from.empty? and to.empty?
      @note.val = I18n.t('Transaction was changed')
    else
      to.each_index do |position|
         temp_str += I18n.t('record_changed_placeholder', what: what[position], from: from[position], to: to[position])
         temp_str += '. '
      end
      @note.val = temp_str
    end

    @note.save
  end

  filterrific(
      default_filter_params: { sorted_by: 'date_desc' },
      available_filters: [
          :sorted_by,
          :with_user_from_id,
          :with_user_to_id,
          :with_source_id,
          :date_gte,
          :date_lt,
          :search_query,
      ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    terms = query.to_s.mb_chars.downcase.split(/\s+/)

    terms = terms.map { |e|
      ('%' + e + '%').gsub(/%+/, '%')
    }
    num_or_conds = 6
    #joins(:s_additionals => :additional).joins(:s_materials => :name).joins(:s_others => :name).joins(:s_tools => :name).where(
     joins('LEFT OUTER JOIN `s_transaction_additionals` ON `s_transaction_additionals`.`s_transaction_id` = `s_transactions`.`id`')
    .joins('LEFT OUTER JOIN `s_additionals` ON `s_additionals`.`id` = `s_transaction_additionals`.`s_additional_id`')
    .joins('LEFT OUTER JOIN `additionals` ON `additionals`.`id` = `s_additionals`.`additional_id`')
    .joins('LEFT OUTER JOIN `s_transaction_materials` ON `s_transaction_materials`.`s_transaction_id` = `s_transactions`.`id`')
    .joins('LEFT OUTER JOIN `s_materials` ON `s_materials`.`id` = `s_transaction_materials`.`s_material_id`')
    .joins('LEFT OUTER JOIN `materials` ON `materials`.`id` = `s_materials`.`name_id`')
    .joins('LEFT OUTER JOIN `s_transaction_others` ON `s_transaction_others`.`s_transaction_id` = `s_transactions`.`id`')
    .joins('LEFT OUTER JOIN `s_others` ON `s_others`.`id` = `s_transaction_others`.`s_other_id`')
    .joins('LEFT OUTER JOIN `others` ON `others`.`id` = `s_others`.`name_id`')
    .joins('LEFT OUTER JOIN `s_transaction_tools` ON `s_transaction_tools`.`s_transaction_id` = `s_transactions`.`id`')
    .joins('LEFT OUTER JOIN `s_tools` ON `s_tools`.`id` = `s_transaction_tools`.`s_tool_id`')
    .joins('LEFT OUTER JOIN `tools` ON `tools`.`id` = `s_tools`.`name_id`')
    .where(
        terms.map { |term|
          "(LOWER(document_number) LIKE ? or LOWER(additionals.name) LIKE ? or LOWER(materials.name) LIKE ? or LOWER(others.name) LIKE ? or LOWER(tools.name) LIKE ? or LOWER(s_tools.inventory_number) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    ).distinct
  }

  scope :with_user_to_id, lambda { |user_to_ids|
    where(user_to_id: [*user_to_ids])
  }

  scope :with_user_from_id, lambda { |user_from_ids|
    where(user_from_id: [*user_from_ids])
  }

  scope :with_source_id, lambda { |facilities_ids|
    where('`s_transactions`.`source_id` in (?) OR `s_transactions`.`destination_id` in (?)', facilities_ids, facilities_ids)
  }

  scope :date_gte, lambda { |reference_time|
    where('s_transactions.date >= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :date_lt, lambda { |reference_time|
    where('s_transactions.date < ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }
  scope :by_created_date, lambda {
    order('s_transactions.created_at desc')
  }

  scope :in_facility, lambda { |facility|
    where(destination: facility).where('s_transactions.operation_type = \'outcome\' or s_transactions.operation_type = \'transfer\'')
  }

  scope :out_facility, lambda { |facility|
    where(source: facility).where('s_transactions.operation_type = \'income\' or s_transactions.operation_type = \'transfer\'')
  }

  scope :in_employee, lambda { |employee|
    where(employee: employee).where(operation_type: 'outcome')
  }

  scope :out_employee, lambda { |employee|
    where(employee: employee).where(operation_type: 'income')
  }


  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^date/
        order("s_transactions.date #{ direction }")
      when /^source/
        joins(:source).order("LOWER(facilities.name) #{ direction }")
      when /^destination/
        joins(:destination).order("LOWER(facilities.name) #{ direction }")
      when /^user_from/
        joins(:user_from).order("LOWER(users.name) #{ direction }")
      when /^user_to/
        joins(:user_to).order("LOWER(users.name) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def get_transaction_icon
    unless self.operation_type.blank?
      color = 'text-green'
      label = I18n.t('simple_form.labels.s_transaction.%s'%[self.operation_type])
      icon = 'fa-arrow-up'
      if self.operation_type == 'outcome' or self.operation_type == 'exit'
        color = 'text-red'
        icon = 'fa-arrow-down'
      end
      if self.operation_type == 'transfer'
        color = 'text-yellow'
        icon = 'fa-arrows-h'
      end
      '<div class="%s" title="%s"><i class="fa %s"></i></div>' % [color, label, icon]
    end
  end

end
