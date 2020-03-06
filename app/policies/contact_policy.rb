class ContactPolicy < ApplicationPolicy

  def can_index?
    user.manager? or user.headmanager? or super
  end

  def can_view?
    user.manager? or user.headmanager? or super
  end

  def can_create?
    user.manager? or user.headmanager? or super
  end

  def can_edit?
    user.manager? or user.headmanager? or super
  end

  def can_delete?
    user.headmanager? or super
  end

end
