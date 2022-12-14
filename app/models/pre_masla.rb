class PreMasla < ApplicationRecord
  belongs_to :masla, class_name: "masla", foreign_key: "masla_id"
end
