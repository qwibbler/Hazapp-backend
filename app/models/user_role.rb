class UserRole < ApplicationRecord
  has_many :users, dependent: :nullify
end
