class PokemonCrawlWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(latitude, longitude, area = "")
    crawler = PokemonCrawler.new(latitude, longitude)
    pokemons = crawler.parse

    pokemons.each do |pokemon|
      pm = Pokemon.find_or_create_by(pokevision_uri: pokemon.pokevision_uri)
      pm.update(obj_to_hash(pokemon).merge(area: area))
    end
  end

  private

  def obj_to_hash(obj)
    JSON.parse(obj.to_json)
  end
end
