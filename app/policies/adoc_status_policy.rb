class AdocStatusPolicy < ApplicationPolicy

  def can_index?
    user.engineer? or super
  end

  def can_view?
    user.engineer? or super
  end

  def can_create?
    user.engineer? or super
  end

  def can_edit?
    user.engineer? or super
  end

  def can_delete?
    user.engineer? or super
  end

end
