class LeadPolicy < ApplicationPolicy

  def create_note?
    can_edit?
  end

  def destroy_note?
    can_delete?
  end

  def create_error?
    can_view?
  end

  def can_index?
    user.headmanager? or user.manager? or super
  end

  def can_view?
    user.headmanager? or (user.manager? and record.created_by == user) or super
  end

  def can_create?
    user.headmanager? or user.manager? or super
  end

  def can_edit?
    user.headmanager? or (user.manager? and record.created_by == user) or super
  end

  def can_delete?
    user.headmanager? or (user.manager? and record.created_by == user) or super
  end

  def has_full_access?
    user.headmanager? or user.admin_role?
  end


end
