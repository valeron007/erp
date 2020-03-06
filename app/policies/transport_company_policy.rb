class TransportCompanyPolicy < ApplicationPolicy
  def can_index?
    user.supplier? or super
  end

  def can_view?
    user.supplier? or super
  end

  def can_create?
    user.supplier? or super
  end

  def can_edit?
    user.supplier? or super
  end

  def can_delete?
    user.supplier? or super
  end
end
