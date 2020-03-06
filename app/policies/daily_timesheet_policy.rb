class DailyTimesheetPolicy < ApplicationPolicy

  def can_index?
    user.foreman? or user.headforeman? or super
  end

  def can_export?
    user.foreman? or user.headforeman? or super
  end

  def can_view?
    #(user.foreman? and record.facility.foreman == user) or super
    user.foreman? or user.headforeman? or super
  end

  def can_create?
    super
  end

  def can_edit?
    super
  end

  def can_delete?
    super
  end

end
