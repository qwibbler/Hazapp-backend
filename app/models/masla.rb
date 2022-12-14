class Masla < ApplicationRecord
  has_many :pre_maslas, class_name: "pre_masla", foreign_key: "reference_id"
end
