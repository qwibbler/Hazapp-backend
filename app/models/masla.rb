class Masla < ApplicationRecord
  belongs_to :user, optional: true
  has_many :more_infos, dependent: :destroy

  def info(info_name)
    more_infos.find_by(info: info_name)&.value
  end

  def more_info_cols
    more_infos.distinct.pluck('info')
  end
end
