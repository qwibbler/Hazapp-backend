class Masla < ApplicationRecord
  has_many :more_infos, dependent: :destroy
end
