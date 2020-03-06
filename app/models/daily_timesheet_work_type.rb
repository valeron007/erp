class DailyTimesheetWorkType < ActiveRecord::Base
  belongs_to :daily_timesheet, inverse_of: :daily_timesheet_work_types
  belongs_to :work_type

  validates :daily_timesheet, :work_type, :amount,  presence: true
  validates :amount,  numericality: {greater_than: 0}
  before_validation :format_amount

  private

  def format_amount
    self.amount = self.attributes_before_type_cast["amount"].to_s.gsub(",", ".").to_f
  end
end
