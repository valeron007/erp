class DocumentPolicy < ApplicationPolicy

  def can_index?
    any_role?
  end

  def can_view?
    !record.roles.blank? ? JSON.parse(record.roles).include?(user.role) : super or super
  end

  def history?
    admin_role?
  end

  def can_edit?
    user.headforeman? or super
  end
end
