class EmployeePolicy < ApplicationPolicy

  def search?
    user.foreman? or admin_role?
  end

  def upload_image?
    can_edit?
  end

  def crop_image?
    can_edit?
  end

  def create_note?
    can_edit?
  end

  def destroy_note?
    can_delete?
  end

  def can_index?
    user.foreman? or user.headforeman? or super
  end

  def can_view?
    user.foreman? or user.headforeman? or super
  end

  def can_create?
    super
  end

  def can_edit?
    super
  end

  def can_delete?
    super
  end

  def can_export?
    super
  end

  def show_docs?
    admin_role?
  end

  def edit_docs?
    admin_role?
  end

  def show_cards?
    admin_role?
  end

  def edit_cards?
    admin_role?
  end

  def show_objects?
    admin_role?
  end

end
