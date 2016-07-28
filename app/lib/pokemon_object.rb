class PokemonObject
  attr_reader :pokemon_id, :uid, :image_uri, :expire_at,
              :latitude, :longitude, :is_alive, :pokevision_uri

  POKEVISION_URI = "https://pokevision.com"
  IMG_URI = "https://ugc.pokevision.com"
  SEC_IN_MIN = 60

  def initialize(json)
    @pokemon_id = json["pokemonId"]
    @uid = json["id"]
    @image_uri = img(json["pokemonId"])
    @expire_at = expire_time(json["expiration_time"])
    @latitude = json["latitude"]
    @longitude = json["longitude"]
    @is_alive = json["is_alive"]
    @pokevision_uri = pokevision_link(@latitude, @longitude)
  end

  private

  def img(id)
    "#{IMG_URI}/images/pokemon/#{id}.png"
  end

  def expire_time(time_int)
    Time.at(time_int)
  end

  def pokevision_link(lat, long)
    "#{POKEVISION_URI}/#/@#{lat},#{long}"
  end
end
