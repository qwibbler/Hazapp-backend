class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, :registerable,
         :recoverable, :rememberable, # :validatable
         authentication_keys: [:username],
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  validates :username, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  belongs_to :user_role
  has_many :maslas, dependent: :nullify
  has_many :more_infos, through: :maslas, dependent: :nullify

  delegate :name, :label, to: :user_role, prefix: :role, allow_nil: true
  delegate :can_delete, :can_update, to: :user_role, prefix: false, allow_nil: true

  def personal_masla
    Masla.find(masla_id) if personal_apper? && !masla_id.nil?
  end

  def admin?
    role_name == 'admin'
  end

  def hazapper?
    role_name == 'hazapper' || user_role.nil?
  end

  def personal_apper?
    role_name == 'personal_apper'
  end

  private

  def password_required?
    new_record? || password.present?
  end
end
