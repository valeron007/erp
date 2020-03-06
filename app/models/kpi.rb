class Kpi < ActiveRecord::Base

  validates :name,:weight,:norm,:roles, presence: true


  def to_s
    name
  end

  def to_label
    to_s
  end

  def roles_to_s
    JSON.parse(roles).reject(&:blank?).collect {|role| I18n.t("user.role.#{role}")}.join(', ') unless roles.blank?
  end

  scope :for_user, lambda{ |user| where("roles LIKE '%#{user.role}%'") unless user.admin_role? }

end
