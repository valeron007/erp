class DailyTimesheet < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :facility, -> { with_deleted }
  belongs_to :employee
  belongs_to :salary_period
  belongs_to :payment_type
  belongs_to :daily_timesheet_status

  has_many :daily_timesheet_work_types, inverse_of: :daily_timesheet
  has_many :daily_timesheet_penalties, inverse_of: :daily_timesheet

  accepts_nested_attributes_for :daily_timesheet_work_types, reject_if: proc { |attributes| attributes['amount'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :daily_timesheet_penalties, reject_if: :all_blank, allow_destroy: true

  validates :facility, :employee, :date,  :payment_type, :ratio, :salary, :daily_timesheet_status,  presence: true
  validates :start_time, :end_time, presence: true, unless: :no_work?
  validates :salary, numericality: { greater_than_or_equal_to: 0 }

  #validates :daily_timesheet_work_types, presence: true, if: :status_not_draft?

  def time_period
    if no_work?
      I18n.t('simple_form.labels.daily_timesheet.no_work')
    else
      "#{h_time(start_time)}-#{h_time(end_time)}"
    end
  end

  def status_not_draft?
    !daily_timesheet_status.blank? && daily_timesheet_status != DailyTimesheetStatus.draft;
  end

  def no_work?
    no_work
  end

  filterrific(
      default_filter_params: { sorted_by: 'date_desc' },
      available_filters: [
          :sorted_by,
          :with_employee_id,
          :with_facility_id,
          :with_status_id,
          :with_payment_type_id,
          :date_gte,
          :date_lte,
      ]
  )
  self.per_page = 10

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    terms = query.to_s.mb_chars.downcase.split(/\s+/)

    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    num_or_conds = 3
    joins(:employee).where(
        terms.map { |term|
          "(LOWER(employees.first_name) LIKE ? OR LOWER(employees.last_name) LIKE ? OR LOWER(employees.middle_name) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }
  scope :with_employee_id, lambda { |employee_ids|
    where(employee_id: [*employee_ids.reject(&:blank?)]) unless employee_ids.reject(&:blank?).blank?
  }
  scope :with_facility_id, lambda { |facility_ids|
    where(facility_id: [*facility_ids]) unless facility_ids.blank?
  }
  scope :with_status_id, lambda { |status_ids|
    where(daily_timesheet_status_id: [*status_ids]) unless status_ids.blank?
  }
  scope :with_payment_type_id, lambda { |status_ids|
    where(payment_type_id: [*status_ids]) unless status_ids.blank?
  }
  scope :date_gte, lambda { |reference_time|
    where('daily_timesheets.date >= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :date_lte, lambda { |reference_time|
    where('daily_timesheets.date <= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }
  scope :not_draft, -> { where.not(daily_timesheet_status: DailyTimesheetStatus::DRAFT) }

  scope :by_facility, lambda { |facility|
    where(facility: facility) unless facility.blank?
  }

  scope :for_foreman, lambda{ |user|
    joins(:facility).where('facilities.foreman_id=?', user.id) if user.foreman?
  }

  def self.for_employee (employee, from, to)
    where(employee: employee).date_gte(from).date_lte(to).not_draft
  end

  def self.sum_total
    sum(:total_amount)
  end

  def self.sum_penalty
    joins(daily_timesheet_penalties: :penalty).sum('penalties.penalty_rate')
  end

  def self.sum_workhours
    sum('HOUR(TIMEDIFF(`END_TIME`,`START_TIME`))')
  end

  def self.total_for_employee (employee, from, to, facility = nil)
    where(employee: employee).by_facility(facility).date_gte(from).date_lte(to).sum(:total_amount)
  end

  def self.total_salary_for_employee (employee, from, to, facility = nil)
    where(employee: employee).where(payment_type: PaymentType::TYPE_SALARY).by_facility(facility).date_gte(from).date_lte(to).sum(:total_amount)
  end

  def self.total_piecework_for_employee (employee, from, to, facility = nil)
    where(employee: employee).where(payment_type: PaymentType::TYPE_PIECEWORK).by_facility(facility).date_gte(from).date_lte(to).sum(:total_amount)
  end

  def self.has_piecework_for_employee (employee, from, to, facility = nil)
    where(employee: employee).where(payment_type: PaymentType::TYPE_PIECEWORK).by_facility(facility).date_gte(from).date_lte(to).count > 0
  end

  def self.penalties_for_employees (employee, from, to)
    joins(daily_timesheet_penalties: :penalty).where(employee: employee).date_gte(from).date_lte(to).not_draft.sum('penalties.penalty_rate')
  end

  def self.penalties_list_for_employees (employee, from, to)
    select('DISTINCT penalties.name').joins(daily_timesheet_penalties: :penalty).where(employee: employee).date_gte(from).date_lte(to).not_draft
  end

  def self.facilities_salary_list_for_employees (employee, from, to)
    select('DISTINCT facilities.name').joins(:facility).where(payment_type: PaymentType::TYPE_SALARY).where(employee: employee).date_gte(from).date_lte(to).not_draft
  end

  def self.facilities_piecework_list_for_employees (employee, from, to)
    select('DISTINCT facilities.name').joins(:facility).where(payment_type: PaymentType::TYPE_PIECEWORK).where(employee: employee).date_gte(from).date_lte(to).not_draft
  end

  def penalty_amount
    daily_timesheet_penalties.map {|h| h.penalty.blank? ? 0 :h.penalty.penalty_rate}.sum
  end

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^name/
        joins(:employee).order("LOWER(employees.last_name) #{ direction }, LOWER(employees.first_name) #{ direction }")
      when /^status/
        joins(:daily_timesheet_status).order("LOWER(daily_timesheet_statuses.name) #{ direction }")
      when /^payment_type/
        joins(:payment_type).order("LOWER(payment_types.name) #{ direction }")
      when /^facility/
        joins(:facility).order("LOWER(facilities.name) #{ direction }")
      when /^total/
        order("LOWER(daily_timesheets.total_amount) #{ direction }")
      when /^date/
        order("LOWER(daily_timesheets.date) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

end
