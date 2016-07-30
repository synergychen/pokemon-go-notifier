class Pokemon < ActiveRecord::Base
  scope :active, -> { where("expire_at >= ?", Time.now) }
  scope :expired, -> { where("expire_at < ?", Time.now) }
  scope :wanted, -> { where(pokemon_id: WISH_LIST) }
  scope :to_be_notified, -> { where(pokemon_id: NOTIFICATION_LIST, notified: false) }

  WISH_LIST = [
    3, 6, 9, 31, 34, 38, 65, 68, 76, 83, 89, 94, 103, 105, 110, 115, 122,
    131, 132, 134, 135, 136, 139, 141, 142, 143, 144, 145, 146, 148, 149
  ]

  NOTIFICATION_LIST = [
    6, 68, 83, 94, 115, 122, 130, 131, 132, 137,
    142, 143, 144, 145, 146, 148, 149, 150, 151
  ]

  def self.is_wanted(id)
    WISH_LIST.include?(id)
  end

  def remaining_time
    "#{remaining_sec / 60}:#{remaining_sec % 60}"
  end

  private

  def remaining_sec
    (expire_at - Time.now).to_i
  end
end
