class Pokemon
  attr_reader :id, :image, :expiration_time,
              :latitude, :longitude, :is_alive, :link

  POKEVISION_URI = "https://pokevision.com"
  IMG_URI = "https://ugc.pokevision.com"
  SEC_IN_MIN = 60

  def initialize(json)
    @id = json["pokemonId"]
    @image = img(@id)
    @expiration_sec = json["expiration_time"]
    @expiration_time = expire_in_time(@expiration_sec)
    @latitude = json["latitude"]
    @longitude = json["longitude"]
    @is_alive = json["is_alive"]
    @link = pokevision_link(@latitude, @longitude)
  end

  private

  def img(id)
    "#{IMG_URI}/images/pokemon/#{id}.png"
  end

  def expire_in_time(time_int)
    secs = (Time.at(time_int) - Time.now).to_i
    "#{secs / SEC_IN_MIN}:#{secs % SEC_IN_MIN}"
  end

  def pokevision_link(lat, long)
    "/#{POKEVISION_URI}/#/@#{lat},#{long}"
  end
end
