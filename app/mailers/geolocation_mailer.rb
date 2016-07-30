class GeolocationMailer < ActionMailer::Base
  default from: ENV["gmail_username"]

  def notification_mail(id)
    @pokemon = Pokemon.find(id)

    mail(
      to: ENV["pokemon_email"],
      subject: subject_of(@pokemon)
    )
  end

  private

  def subject_of(pokemon)
    "#{pokemon.pokemon_id}: (#{pokemon.coordinate})"
  end
end
