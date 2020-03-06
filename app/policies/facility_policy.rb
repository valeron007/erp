class FacilityPolicy < ApplicationPolicy

  def create_note?
    can_edit?
  end

  def destroy_note?
    can_delete?
  end

  def can_index?
    user.storekeeper? or user.foreman? or user.headforeman? or user.engineer? or super
  end

  def can_view?
    user.storekeeper? or (user.foreman? and record.foreman == user) or user.headforeman? or user.engineer? or super
  end

  def can_create?
    user.engineer? or super
  end

  def can_edit?
    user.storekeeper? or (user.foreman? and record.foreman == user) or user.headforeman? or user.engineer? or super
  end

  def can_delete?
    user.engineer? or super
  end

  def show_full_info?
    user.engineer? or admin_role?
  end

  def edit_full_info?
    user.engineer? or admin_role?
  end

  def show_contract_info?
    user.admin? or user.engineer?
  end

  def edit_contract_info?
    user.admin? or user.engineer?
  end

  def show_financial_info?
    user.foreman? or user.headforeman? or admin_role?
  end

  def show_docs?
    user.engineer? or admin_role?
  end

  def edit_docs?
    user.engineer? or admin_role?
  end

  def show_works?
    user.storekeeper? or user.engineer? or user.foreman? or user.headforeman? or admin_role?
  end

  def edit_works?
    user.foreman? or user.headforeman? or admin_role? or user.engineer?
  end

  def show_tools?
    user.storekeeper? or user.foreman? or user.headforeman? or admin_role?
  end

  def edit_tools?
    user.foreman? or user.headforeman? or admin_role?
  end

  def show_materials?
    user.storekeeper? or user.foreman? or user.headforeman? or admin_role?
  end

  def edit_materials?
    user.foreman? or user.headforeman? or admin_role?
  end

  def show_others?
    user.storekeeper? or user.foreman? or user.headforeman? or admin_role?
  end

  def show_additionals?
    user.storekeeper? or user.foreman? or user.headforeman? or admin_role?
  end

  def edit_others?
    user.foreman? or user.headforeman? or admin_role?
  end

  def edit_additionals?
    user.foreman? or user.headforeman? or admin_role?
  end

  def show_costs?
    user.foreman? or user.headforeman? or admin_role?
  end

  def edit_costs?
    user.foreman? or user.headforeman? or admin_role?
  end

  def show_leads?
    user.foreman? or user.headforeman? or admin_role?
  end

  def show_objects?
    user.storekeeper? or user.foreman? or user.headforeman? or admin_role?
  end

end
