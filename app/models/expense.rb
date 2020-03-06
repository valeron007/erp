class Expense < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :expense_category
  belongs_to :expense_by, class_name: "User"
  belongs_to :expense_to, class_name: "User"
  belongs_to :created_by, class_name: "User"
  belongs_to :updated_by, class_name: "User"

  validates :direction, :title, :amount, :expense_by, :expense_date, presence: true

  DIRECTION_TRANSFER = 2
  DIRECTION_PLUS = 1
  DIRECTION_MINUS = -1

  scope :for_user, lambda{ |user| where('expense_by_id=? or created_by_id=? or expense_to_id=?', user.id, user.id, user.id) unless user.admin_role? }

  self.per_page = 10

  filterrific(
      default_filter_params: { sorted_by: 'expense_date_desc' },
      available_filters: [
          :sorted_by,
          :search_query,
          :with_category_id,
          :with_expense_by_id,
          :date_gte,
          :date_lte,
      ]
  )

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^title/
        order("LOWER(expenses.title) #{ direction }")
      when /^facility/
        order("LOWER(expenses.facility) #{ direction }")
      when /^company/
        order("LOWER(expenses.company) #{ direction }")
      when /^amount/
        order("LOWER(expenses.amount) #{ direction }")
      when /^expense_date/
        order("LOWER(expenses.expense_date) #{ direction }")
      when /^expense_by/
        joins(:expense_by).order("LOWER(users.name) #{ direction }")
      when /^expense_to/
        joins(:expense_to).order("LOWER(users.name) #{ direction }")
      when /^expense_category/
        joins(:expense_category).order("LOWER(expense_categories.name) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    terms = query.to_s.mb_chars.downcase.split(/\s+/)

    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    num_or_conds = 3
    where(
        terms.map { |term|
          "(LOWER(expenses.title) LIKE ? OR LOWER(expenses.facility) LIKE ? OR LOWER(expenses.company) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :with_category_id, lambda { |status_ids|
    where(expense_category_id: [*status_ids]) unless status_ids.blank?
  }

  scope :with_expense_by_id, lambda { |expense_by_ids|
    where(expense_by_id: [*expense_by_ids]) unless expense_by_ids.blank?
  }

  scope :date_gte, lambda { |reference_time|
    where('expenses.expense_date >= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  scope :date_lte, lambda { |reference_time|
    where('expenses.expense_date <= ?', DateTime.parse(reference_time)) unless reference_time.blank?
  }

  def self.user_balance (user)
    balance = 0
    where('expense_by_id=? or expense_to_id=?', user.id, user.id).each do |item|
      balance += item.amount if item.is_income? or (item.is_transfer? and item.expense_to == user)
      balance -= item.amount if item.is_outcome? or (item.is_transfer? and item.expense_by == user)
    end
    return balance
  end

  def is_income?
    direction == Expense::DIRECTION_PLUS
  end
  def is_outcome?
    direction == Expense::DIRECTION_MINUS
  end
  def is_transfer?
    direction == Expense::DIRECTION_TRANSFER
  end

  def color
    if is_income?
      'success'
    elsif is_outcome?
      'danger'
    else
      'warning'
    end
  end

end
