class UpdateWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(latitude, longitude, area = "")
    crawler = Crawler.new(latitude, longitude)
    pokemons = crawler.perform

    pokemons.each do |pm|
      next unless Pokemon.wanted(pm.pokemon_id)
      pokemon = Pokemon.find_or_create_by(pokevision_uri: pm.pokevision_uri)
      pokemon.update(obj_to_hash(pm).merge(area: area))
    end
  end

  private

  def obj_to_hash(obj)
    JSON.parse(obj.to_json)
  end
end
