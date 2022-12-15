class Masla < ApplicationRecord
  has_many :pre_maslas, dependent: :destroy
end
