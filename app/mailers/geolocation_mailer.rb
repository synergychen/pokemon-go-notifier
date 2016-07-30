class GeolocationMailer < ActionMailer::Base
  default from: ENV["gmail_username"]

  def new(subject)
    mail(
      to: ENV["pokemon_email"],
      subject: subject,
      body: "",
      content_type: "text/html",
    )
  end
end
