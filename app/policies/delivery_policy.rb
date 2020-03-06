class DeliveryPolicy < ApplicationPolicy

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

  def create_note?
    can_edit?
  end

  def destroy_note?
    can_delete?
  end

  def details?
    can_view?
  end

  def autocomplete_name?
    can_create?
  end
end
