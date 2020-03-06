class AdditionalPolicy < ApplicationPolicy

  def can_index?
    user.storekeeper? or user.supplier? or user.foreman? or user.headforeman? or super
  end

  def can_view?
    user.storekeeper? or user.supplier? or user.foreman? or user.headforeman? or super
  end

  def can_create?
    user.storekeeper? or user.supplier? or user.foreman? or user.headforeman? or super
  end

  def can_edit?
    user.storekeeper? or user.supplier? or user.foreman? or user.headforeman? or super
  end

  def can_delete?
    user.storekeeper? or user.supplier? or user.foreman? or user.headforeman? or super
  end

  def can_view_document_name?
    user.supplier? or admin_role?
  end

end
