class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, :registerable,
         :recoverable, :rememberable, # :validatable
         authentication_keys: [:username],
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  validates :username, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  has_many :maslas, dependent: :nullify
  has_many :more_infos, through: :maslas, dependent: :nullify

  private

  def password_required?
    new_record? || password.present?
  end
end
