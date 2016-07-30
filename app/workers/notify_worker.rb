class NotifyWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Pokemon.to_be_notified.each do |pokemon|
      subject, body = email(pokemon)
      GeolocationMailer.new(subject, body).deliver_later
      pokemon.update(notified: true)
    end
  end

  private

  def email(pokemon)
    [
      "#{pokemon.pokemon_id}: #{pokemon.latitude}, #{pokemon.longitude}",
      pokemon.pokevision_uri
    ]
  end
end
