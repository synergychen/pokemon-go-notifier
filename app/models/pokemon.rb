class Pokemon < ActiveRecord::Base
  def remaining_time
    remaining_sec = (expire_at - Time.now).to_i
    "#{remaining_sec / 60}:#{remaining_sec % 60}"
  end
end
