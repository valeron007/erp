class ReportPolicy < Struct.new(:user, :report)

  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "Must be signed in." unless user
    @user = user
    @record = record
  end

  def dashboard?
    admin_role?
  end

  def employee_payments?
    admin_role?
  end

  def facility_works?
    admin_role?
  end

  def labor_costs?
    admin_role?
  end

  def work_efficiency?
    admin_role?
  end

  def daily_summary?
    admin_role?
  end

  def calc?
    admin_role?
  end

  def admin_role?
    user.admin_role?
  end

end
