class ScanJob < ActiveRecord::Base
  JOB_EXPIRE_SEC = 100

  def self.expired
    Time.now - maximum(:created_at) < JOB_EXPIRE_SEC
  end
end
