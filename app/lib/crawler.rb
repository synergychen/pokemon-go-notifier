require "net/http"

class Crawler
  attr_reader :latitude, :longitude, :job_id

  URI_PREFIX = "https://pokevision.com/map/"
  WAIT_RESPONSE_TIME = 10

  def initialize(latitude, longitude)
    @latitude = latitude.to_s
    @longitude = longitude.to_s
    @job_id = get_job_id
  end

  def perform
    uri = parsing_uri
    data = parse_json(uri)

    raise Exceptions::CrawlError if invalid(data)

    pokemon_objs = data["pokemon"].map do |pokemon_json|
      PokemonObject.new(pokemon_json)
    end

    pokemon_objs.uniq { |e| [e.latitude, e.longitude] }.sort_by(&:pokemon_id)
  rescue => e
    p e.message
    []
  end

  private

  def get_job_id
    ScanJob.last.job_id
  end

  def parsing_uri
    "https://pokevision.com/map/data/#{latitude}/#{longitude}/#{job_id}"
  end

  def parse_json(origin_uri)
    uri = URI(origin_uri)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue => e
    p e.message
  end

  def invalid(data)
    data["status"] != "success" ||
      data["jobStatus"] == "failure" ||
      !data["pokemon"].is_a?(Array)
  end
end
