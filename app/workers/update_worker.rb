class UpdateWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(latitude, longitude, area = "")
    crawler = Crawler.new(latitude, longitude)
    pokemons = crawler.perform

    raise Exceptions::CrawlError unless pokemons.is_a?(Array)

    pokemons.each do |pm|
      next unless Pokemon.is_wanted(pm.pokemon_id)
      pokemon = Pokemon.find_or_create_by(pokevision_uri: pm.pokevision_uri)
      pokemon.update(obj_to_hash(pm).merge(area: area))
    end
  rescue => e
    p e.message
  end

  private

  def obj_to_hash(obj)
    JSON.parse(obj.to_json)
  end
end
