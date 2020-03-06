class STransactionPolicy < ApplicationPolicy
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
    super
  end

  def create_note?
    can_edit?
  end

  def destroy_note?
    can_delete?
  end

  def create_error?
    can_view?
  end

  def details?
    can_view?
  end
end
