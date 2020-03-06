class SMaterialPolicy < ApplicationPolicy
  def can_index?
    user.storekeeper? or user.foreman? or user.headforeman? or super
  end

  def can_view?
    user.storekeeper? or user.foreman? or user.headforeman? or super
  end

  def can_create?
    user.storekeeper? or super
  end

  def can_edit?
    user.storekeeper? or super
  end

  def can_delete?
    user.storekeeper? or super
  end
end
