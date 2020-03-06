class ExpensePolicy < ApplicationPolicy

  def can_index?
    any_role?
  end

  def can_view?
    record.created_by == user or super
  end

  def can_create?
    any_role? or super
  end

  def can_edit?
    record.created_by == user or super
  end

  def can_delete?
    super
  end

  def can_export?
    super
  end

  def can_assign?
    user.admin_role?
  end

end
