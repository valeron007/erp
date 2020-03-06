class ClientPolicy < ApplicationPolicy

  def can_index?
    user.engineer? or user.manager? or user.headmanager? or super
  end

  def can_view?
    user.engineer? or user.manager? or user.headmanager? or super
  end

  def can_create?
    user.engineer? or user.manager? or user.headmanager? or super
  end

  def can_edit?
    user.engineer? or user.manager? or user.headmanager? or super
  end

  def can_delete?
    user.engineer? or user.headmanager? or super
  end

end
