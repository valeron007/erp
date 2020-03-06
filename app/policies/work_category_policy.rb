class WorkCategoryPolicy < ApplicationPolicy

  def can_index?
    user.foreman? or user.headforeman? or super
  end

  def can_view?
    user.foreman? or user.headforeman? or super
  end

  def can_create?
    user.foreman? or user.headforeman? or super
  end

  def can_edit?
    user.foreman? or user.headforeman? or super
  end

  def can_delete?
    user.foreman? or user.headforeman? or super
  end

end
