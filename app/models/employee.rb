class Employee < ActiveRecord::Base
  validates :first_name, :last_name, :position, :presence => true
  validates :salary, :salary_ratio, :shoes_size, :dress_size, :height, :children_count, numericality: {greater_than_or_equal_to: 0}, allow_blank: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  crop_attached_file :avatar
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_attached_file :passport_front, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :passport_front, content_type: /\Aimage\/.*\Z/

  has_attached_file :passport_reg, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :passport_reg, content_type: /\Aimage\/.*\Z/

  has_attached_file :additional_document_1, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :additional_document_1, content_type: /\Aimage\/.*\Z/

  has_attached_file :additional_document_2, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :additional_document_2, content_type: /\Aimage\/.*\Z/

  has_attached_file :additional_document_3, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :additional_document_3, content_type: /\Aimage\/.*\Z/

  belongs_to :position
  belongs_to :employee_status
  belongs_to :fire_reason
  belongs_to :user
  has_many :daily_timesheets
  has_many :employee_notes

  after_save :check_position_changes, :check_ratio_changes

  default_scope { order('LOWER(last_name) ASC, LOWER(first_name) ASC') }

  def self.search_by_phone(phone)
    where("phone_number LIKE ?", "%#{phone}%")
  end

  def self.options_for_select
    order('LOWER(last_name)').map {|e| [e.to_option, e.id, {'data-active' => e.is_active?}] }
  end

  def check_position_changes
    if position_id_changed?
      create_note(I18n.t('Position'), Position.find_by_id(position_id_was), position)
    end
  end

  def check_ratio_changes
    if salary_ratio_changed?
      create_note(I18n.t('Salary ratio'), salary_ratio_was, salary_ratio)
    end
  end

  def create_note(what, from, to)
    @note = EmployeeNote.new
    @note.employee = self
    @note.user = user
    @note.val = I18n.t('record_changed_placeholder', what: what, from: from, to: to)
    @note.save
  end

  filterrific(
      default_filter_params: { sorted_by: 'name_desc' },
      available_filters: [
          :sorted_by,
          :search_query,
          :with_position_id,
          :with_employee_status_id,
          :hire_date_gte,
          :hire_date_lt,
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
    where(
        terms.map { |term|
          "(LOWER(employees.first_name) LIKE ? OR LOWER(employees.last_name) LIKE ? OR LOWER(employees.middle_name) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :with_position_id, lambda { |position_ids|
    where(position_id: [*position_ids])
  }

  scope :with_employee_status_id, lambda { |employee_status_ids|
    where(employee_status_id: [*employee_status_ids]) unless employee_status_ids.blank?
  }

  scope :hire_date_gte, lambda { |reference_time|
    where('employees.hire_date >= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :hire_date_lt, lambda { |reference_time|
    where('employees.hire_date < ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :upcoming_dob, -> {
    date_start = Date.today
    date_end = Date.today + 30

    field = 'birth_date'

    if date_end.strftime('%m%d') < date_start.strftime('%m%d') # year change
      where_sql = "(DATE_FORMAT(`#{field}`, '%m%d') >= \"0101\" AND DATE_FORMAT(`#{field}`, '%m%d') <= \"#{date_end.strftime('%m%d')}\")"
      where_sql << " OR (DATE_FORMAT(`#{field}`, '%m%d') >= \"#{date_start.strftime('%m%d')}\" AND DATE_FORMAT(`#{field}`, '%m%d') <= \"1231\")"
    else
      where_sql = "DATE_FORMAT(`#{field}`, '%m%d') >= \"#{date_start.strftime('%m%d')}\" AND DATE_FORMAT(`#{field}`, '%m%d') <= \"#{date_end.strftime('%m%d')}\""
    end
    #where_sql += " and ( (employees.employee_status_id = #{EmployeeStatus::ACTIVE} and employees.position_id = #{Position::WORKER}) or employees.position_id != #{Position::WORKER})"
    where_sql += " and ( employees.employee_status_id = #{EmployeeStatus::ACTIVE} )"
    where(where_sql).reorder(nil).order("DATE_FORMAT(`#{field}`, '%m%d') ASC")
  }

  scope :timesheet_date_from, lambda { |reference_time|
    joins(:daily_timesheets).where('daily_timesheets.date >= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }
  scope :timesheet_date_to, lambda { |reference_time|
    joins(:daily_timesheets).where('daily_timesheets.date <= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }
  scope :timesheet_not_draft, -> { joins(:daily_timesheets).where('daily_timesheets.daily_timesheet_status_id != ?', DailyTimesheetStatus::DRAFT) }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^name/
        order("LOWER(employees.last_name) #{ direction }, LOWER(employees.first_name) #{ direction }")
      when /^position/
        joins(:position).order("LOWER(positions.name) #{ direction }")
      when /^employee_status/
        joins(:employee_status).order("LOWER(employee_statuses.name) #{ direction }")
      when /^hire_date/
        order("LOWER(employees.hire_date) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  #TODO Hardcoded hack, please consider adding can_issue_penalty attribute to position instead.
  scope :can_issue_penalty, -> { where('employees.position_id in (?)', [1,2,6,7,9,10,13]) }

  def self.get_timesheets (name, from, to, facility = nil)
    #where_sql = "daily_timesheets.daily_timesheet_status_id != #{DailyTimesheetStatus::DRAFT}"
    where_sql = ""
    where_sql += " daily_timesheets.date >= '#{from.to_date}'" unless from.blank?
    where_sql += " and " unless where_sql.blank?
    where_sql += " daily_timesheets.date <= '#{to.to_date}'" unless to.blank?
    where_sql += " and " unless facility.blank?
    where_sql += " daily_timesheets.facility_id = #{facility.id}" unless facility.blank?
    joins(:daily_timesheets).where(where_sql).search_query(name).distinct
  end

  scope :active, -> { where(employee_status_id: EmployeeStatus.active) }
  scope :active_not_worker, -> { where(employee_status_id: EmployeeStatus.active).where.not(position_id: 3)  }

  scope :for_timesheet, lambda { |employee|
    where_sql = "employees.employee_status_id = #{EmployeeStatus::ACTIVE}"
    where_sql += " or employees.id = #{employee.id}" unless employee.blank?
    where(where_sql).distinct
  }

  def self.has_timesheets (name, from, to)
    search_query(name).timesheet_date_from(from).timesheet_date_to(to).timesheet_not_draft.distinct
  end

  def is_active?
    has_attribute?(:employee_status_id) && employee_status_id == EmployeeStatus::ACTIVE
  end

  def to_s
    "#{last_name} #{first_name} #{middle_name}" + (!is_active? ? ", #{employee_status}":'')
  end

  def to_label
    to_s
  end

  def to_option
    "#{last_name} #{first_name} #{middle_name}"
  end

  def to_birthday
    Date.parse(birth_date.strftime('%m%d')) unless birth_date.blank?
  end

end
