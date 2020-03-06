class DailyWorkPolicy < ApplicationPolicy

  def can_index?
    any_role?
  end

  def can_view?
    record.user == user or super
  end

  def can_create?
    any_role? or super
  end

  def can_edit?
    record.user == user or super
  end

  def can_delete?
    record.user == user or super
  end

  def can_export?
    any_role?
  end

  def can_assign?
    user.admin_role?
  end

end
