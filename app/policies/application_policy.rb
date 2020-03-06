class ApplicationPolicy
  attr_reader :user, # User performing the action
              :record # Instance upon which action is performed

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "Must be signed in." unless user
    @user = user
    @record = record
  end

  def index?
    can_index?
  end

  def show?
    can_view?
  end

  def new?
    can_create?
  end

  def create?
    can_create?
  end

  def edit?
    can_edit?
  end

  def update?
    can_edit?
  end

  def destroy?
    can_delete?
  end

  def export?
    can_export?
  end

  def any_role?
    !user.nil?
  end

  def can_index?
    admin_role?
  end

  def can_view?
    admin_role?
  end

  def can_create?
    admin_role?
  end

  def can_edit?
    admin_role?
  end

  def can_delete?
    admin_role?
  end

  def can_export?
    admin_role?
  end

  def admin_role?
    user.admin_role?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end