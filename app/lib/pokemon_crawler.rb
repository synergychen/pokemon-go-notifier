require "net/http"

class PokemonCrawler
  attr_reader :latitude, :longitude

  URI_PREFIX = "https://pokevision.com/map/"
  WAIT_RESPONSE_TIME = 7

  def initialize(latitude, longitude)
    @latitude = latitude.to_s
    @longitude = longitude.to_s
  end

  def parse
    scan_result = scan

    return "scan fail" unless scan_result["status"] == "success"

    job_id = scan_result["jobId"]
    uri = URI_PREFIX + "data/" + latitude + "/" + longitude + "/" + job_id
    sleep WAIT_RESPONSE_TIME
    data = parse_json(uri)

    return "scan job not ready..." if data.has_key? "jobStatus"
    return "fail" unless data["status"] == "success"

    pre_process(data["pokemon"])
  rescue => e
    p e.message
  end

  def scan
    uri = URI_PREFIX + "scan/" + latitude + "/" + longitude
    parse_json(uri)
  rescue => e
    p e.message
  end

  private

  def parse_json(origin_uri)
    uri = URI(origin_uri)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue => e
    p e.message
  end

  def pre_process(pokemons)
    pokemon_objs = pokemons.map do |pokemon_json|
      Pokemon.new(pokemon_json)
    end

    pokemon_objs.uniq { |e| [e.latitude, e.longitude] }.sort_by(&:id)
  end
end
