class DailyWork < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :user
  has_many :daily_work_kpis, inverse_of: :daily_work

  accepts_nested_attributes_for :daily_work_kpis, reject_if: proc { |a| a[:title].blank? }, allow_destroy: true

  validates :user, :date, presence: true

  filterrific(
      default_filter_params: { sorted_by: 'date_desc' },
      available_filters: [
          :sorted_by,
          :with_user_id,
          :date_gte,
          :date_lte,
      ]
  )
  self.per_page = 10

  scope :for_user, lambda{ |user| where('user_id=?', user.id) unless user.admin_role? }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^date/
        order("LOWER(daily_works.date) #{ direction }")
      when /^user/
        joins(:user).order("LOWER(users.name) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_user_id, lambda { |user_ids|
    where(user_id: [*user_ids]) unless user_ids.blank?
  }
  scope :date_gte, lambda { |reference_time|
    where('daily_works.date >= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :date_lte, lambda { |reference_time|
    where('daily_works.date <= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

end
