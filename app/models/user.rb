# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  role                   :integer
#

class User < ActiveRecord::Base
  enum role: [
      :admin,
      :storekeeper,
      :driver,
      :supplier,
      :office,
      :engineer,
      :foreman,
      :chief,
      :head,
      :accountant,
      :manager,
      :headmanager,
      :employee,
      :headforeman
  ]
  after_initialize :set_default_role, :if => :new_record?

  has_many :lead_notes
  has_many :employee_notes
  has_many :employees

  default_scope { order('LOWER(name) ASC') }

  def set_default_role
    self.role ||= :employee
  end

  def admin_role?
    self.admin? or self.office?
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.roles_attributes_for_select
    roles.map do |role, _|
      [I18n.t("#{model_name.i18n_key}.role.#{role}"), role]
    end
  end

  def to_s
    name
  end

  def to_label
    to_s
  end

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

end
