class GeolocationMailer < ActionMailer::Base
  default from: ENV["gmail_username"]

  def new(subject, body)
    mail(
      to: ENV["pokemon_email"],
      subject: subject,
      body: body,
      content_type: "text/html",
    )
  end
end
