class SToolPolicy < ApplicationPolicy
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

  def update_locations?
    user.storekeeper? or user.admin_role?
  end

  def get_current_location?
    can_view?
  end

  def can_update_locations?
    update_locations?
  end
end
