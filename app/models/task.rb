class Task < ActiveRecord::Base
  validates :title, :desc, :assign_date, :task_status, :assigned_by, :assigned_to, :presence => true

  belongs_to :task_status
  belongs_to :assigned_by, class_name: "User"
  belongs_to :assigned_to, class_name: "User"
  belongs_to :created_by, class_name: "User"
  belongs_to :updated_by, class_name: "User"

  has_many :task_notes
  has_paper_trail on: [:update], only: [:title, :desc, :task_status_id, :result, :done_date, :finish_date, :note_list, :file_list]

  mount_uploaders :files, TaskUploader
  serialize :files, JSON

  before_validation do
    update_file_list
    update_note_list
  end

  before_save :update_done_date, if: Proc.new {|t| t.task_status_id_changed? and t.task_status.is_finished?}

  def update_file_list
    self.file_list = get_file_list if self.file_list != get_file_list && !JSON::parse(get_file_list).empty?
  end

  def update_note_list
    self.note_list = get_note_list if self.note_list != get_note_list && !JSON::parse(get_note_list).empty?
  end

  def get_file_list
    self.files.map { |f| f.file.original_filename }.to_json
  end

  def get_note_list
    self.task_notes.pluck(:val).to_json
  end

  def file_list
    JSON::parse(super) if super
  end

  def note_list
    JSON::parse(super) if super
  end

  def update_done_date
    self.done_date = Time.now
  end

  def to_s
    title
  end

  def closed?
    task_status_id == TaskStatus.finished_id
  end

  def not_closed?
    !closed?
  end

  def last_changed_by
    User.find_by(id: versions.last&.whodunnit)
  end

  scope :for_user, lambda{ |user| where('created_by_id=? OR assigned_by_id=? OR assigned_to_id=?', user.id, user.id, user.id) unless user.admin_role? }
  scope :assigned_to, lambda{ |user| where('assigned_to_id=?', user.id) }

  scope :upcoming_tasks, -> {
    where('finish_date <= ?', 2.days.from_now)
  }
  scope :not_closed, -> {
    where('task_status_id != ?', TaskStatus.finished_id)
  }
  scope :assigned, -> {
    where('task_status_id = ?', TaskStatus.assigned_id)
  }

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    terms = query.to_s.mb_chars.downcase.split(/\s+/)

    terms = terms.map { |e|
      ('%' + e + '%').gsub(/%+/, '%')
    }
    num_or_conds = 2
    where(
        terms.map { |term|
          "(LOWER(tasks.title) LIKE ? OR LOWER(tasks.desc) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  filterrific(
      default_filter_params: { sorted_by: 'finish_date_desc' },
      available_filters: [
          :sorted_by,
          :search_query,
          :with_task_status_id,
          :with_assigned_to_id,
          :finish_date_gte,
          :finish_date_lt,
      ]
  )

  self.per_page = 10

  scope :with_assigned_to_id, lambda { |assigned_to_ids|
    where(assigned_to_id: [*assigned_to_ids]) unless assigned_to_ids.blank?
  }

  scope :with_task_status_id, lambda { |task_status_ids|
    where(task_status_id: [*task_status_ids]) unless task_status_ids.blank?
  }
  scope :finish_date_gte, lambda { |reference_time|
    where('tasks.finish_date >= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :finish_date_lt, lambda { |reference_time|
    where('tasks.finish_date < ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^title/
        order("LOWER(tasks.title) #{ direction }")
      when /^assign_date/
        order("tasks.assign_date #{ direction }")
      when /^finish_date/
        order("tasks.finish_date #{ direction }")
      when /^done_date/
        order("tasks.done_date #{ direction }")
      when /^updated_at/
        order("tasks.updated_at #{ direction }")
      when /^assigned_by/
        joins(:assigned_by).order("LOWER(users.name) #{ direction }")
      when /^assigned_to/
        joins(:assigned_to).order("LOWER(users.name) #{ direction }")
      when /^task_status/
        joins(:task_status).order("`task_statuses`.`order` #{ direction }")
      when /^important/
        order("tasks.important #{ direction }")
      when /^urgent/
        order("tasks.urgent #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

end
