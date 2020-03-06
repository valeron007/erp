class DailyWorkKpi < ActiveRecord::Base
  belongs_to :daily_work
  belongs_to :kpi
  belongs_to :task

  validates :title, presence: true

  def to_s
    hours.blank? ? "#{title}" : "#{title} - #{hours}" + I18n.t('Hours') + ' '
  end

  def to_label
    to_s
  end

end
