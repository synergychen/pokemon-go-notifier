class ExpiredCleanWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Pokemon.expired.destroy_all
  end
end
