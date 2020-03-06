class ReportController::ReportFilter
  include ActiveModel::Model

  attr_accessor :facility_id, :employee_name, :date_range, :date_from, :date_to

  def day_diff
    res = (DateTime.parse(date_to) - DateTime.parse(date_from)).to_i + 1 unless date_to.blank? or date_from.blank?
    res ||= 0
  end
end