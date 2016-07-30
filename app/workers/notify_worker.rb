class NotifyWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(subject)
    GeolocationMailer.new(subject).deliver_later
  end
end
