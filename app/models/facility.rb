class Facility < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :facility_status

  belongs_to :foreman, class_name: "User"
  belongs_to :lead
  belongs_to :client

  has_many :adocs, inverse_of: :facility

  has_many :facility_work_types, inverse_of: :facility
  has_many :facility_tools, inverse_of: :facility
  has_many :facility_materials, inverse_of: :facility
  has_many :facility_others, inverse_of: :facility
  has_many :facility_additionals, inverse_of: :facility
  has_many :facility_costs, inverse_of: :facility

  has_many :facility_notes
  has_many :daily_timesheets

  accepts_nested_attributes_for :adocs, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :facility_work_types, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :facility_tools, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :facility_materials, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :facility_others, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :facility_additionals, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :facility_costs, reject_if: :all_blank, allow_destroy: true

  validates :full_name, :name, :address, :facility_status, presence: true

  before_save :update_close_date, if: Proc.new { |f| f.facility_status_id_changed? and f.facility_status.closed? and f.finish_date.nil? }
  before_save :update_status_change_date, if: Proc.new { |f| f.facility_status_id_changed? }
  
  before_save :format_p_total
  before_save :format_p_paid
  before_save :format_p_left

  def first_timesheet_date
    daily_timesheets.first.created_at.strftime("%d.%m.%Y") if daily_timesheets.present?
  end

  def last_timesheet_date
    daily_timesheets.last.created_at.strftime("%d.%m.%Y") if daily_timesheets.present?
  end

  def update_close_date
    self.finish_date = Time.now
  end
  def update_status_change_date
    self.status_change_date = Time.now
  end

  self.per_page = 10

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

  scope :reportable, -> { where('facilities.facility_status_id is null or facilities.facility_status_id > ?', FacilityStatus.draft) }

  scope :for_timesheet, lambda { |facility|
    where_sql = "facilities.facility_status_id is null or facilities.facility_status_id = #{FacilityStatus::OPEN} or facilities.facility_status_id = #{FacilityStatus::REOPEN}"
    where_sql += " or facilities.id = #{facility.id}" unless facility.blank?
    where(where_sql).distinct
  }

  scope :for_foreman, lambda{ |user|
    user.foreman? ? where('facilities.foreman_id=?', user.id) : all
  }

  filterrific(
      default_filter_params: { sorted_by: 'name_desc' },
      available_filters: [
          :sorted_by,
          :search_query,
          :with_facility_status_id,
      ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    terms = query.to_s.mb_chars.downcase.split(/\s+/)

    terms = terms.map { |e|
      ('%' + e + '%').gsub(/%+/, '%')
    }
    num_or_conds = 2
    where(
        terms.map { |term|
          "(LOWER(facilities.name) LIKE ? OR LOWER(facilities.contract_number) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :with_facility_status_id, lambda { |facility_status_ids|
    where(facility_status_id: [*facility_status_ids])
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^name/
        order("LOWER(facilities.name) #{ direction }")
      when /^foreman/
        joins(:foreman).order("LOWER(foremans.name) #{ direction }")
      when /^facility_status/
        joins(:facility_status).order("LOWER(facility_statuses.name) #{ direction }")
      when /^status_change_date/
        order("status_change_date #{ direction }")
      when /^contract_number/
        order("contract_number #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def is_active?
    facility_status_id == FacilityStatus::OPEN or facility_status_id == FacilityStatus::REOPEN
  end

  def to_s
    "#{name} (#{address})" + (!is_active? ? ", #{facility_status}":'') + (deleted? ? ", #{I18n.t('Deleted')}":'')
  end

  def to_label
    to_s
  end

  private

  def format_p_total
    self.p_total = self.attributes_before_type_cast["p_total"].to_s.gsub(",", ".").to_f
  end

  def format_p_paid
    self.p_paid = self.attributes_before_type_cast["p_paid"].to_s.gsub(",", ".").to_f
  end

  def format_p_left
    self.p_left = self.attributes_before_type_cast["p_left"].to_s.gsub(",", ".").to_f
  end
end
