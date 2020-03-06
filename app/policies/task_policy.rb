class TaskPolicy < ApplicationPolicy

  def create_note?
    can_edit?
  end

  def destroy_note?
    can_delete?
  end

  def can_index?
    any_role?
  end

  def can_view?
    record.created_by == user or record.assigned_to == user or record.assigned_by == user or super
  end

  def can_create?
    any_role? or super
  end

  def can_edit?
    record.created_by == user or record.assigned_to == user or record.assigned_by == user or super
  end

  def can_delete?
    record.created_by == user or super
  end

  def close?
    can_edit?
  end

  def open?
    can_edit?
  end

  def history?
    user.admin_role?
  end
end
