class Pokemon < ActiveRecord::Base
  scope :expired, -> { where("expire_at < ?", Time.now) }

  def remaining_time
    "#{remaining_sec / 60}:#{remaining_sec % 60}"
  end

  private

  def remaining_sec
    (expire_at - Time.now).to_i
  end
end
