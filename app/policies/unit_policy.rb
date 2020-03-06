class UnitPolicy < ApplicationPolicy

  def can_index?
    user.storekeeper? or user.supplier? or super
  end

  def can_view?
    user.storekeeper? or user.supplier? or super
  end

  def can_create?
    user.storekeeper? or user.supplier? or super
  end

  def can_edit?
    user.storekeeper? or user.supplier? or super
  end

  def can_delete?
    user.storekeeper? or user.supplier? or super
  end

end
