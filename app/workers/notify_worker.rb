class NotifyWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Pokemon.to_be_notified.each do |pokemon|
      GeolocationMailer.notification_mail(pokemon.id).deliver_later
      pokemon.update(notified: true)
    end
  end
end
