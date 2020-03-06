class DailyTimesheetPenalty < ActiveRecord::Base
  belongs_to :daily_timesheet, inverse_of: :daily_timesheet_penalties
  belongs_to :penalty
  belongs_to :employee

  validates :daily_timesheet, :penalty, :employee, presence: true

  def to_s
    penalty.to_s
  end
end
