class Masla < ApplicationRecord
  belongs_to :user, optional: true
  has_many :more_infos, dependent: :destroy
end
