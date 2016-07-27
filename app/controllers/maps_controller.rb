class MapsController < ApplicationController
  def index
    # todo: remove hard code geo coordinate
    lat = 40.76546147212545
    long = -73.97935867309569
    crawler = PokemonCrawler.new(lat, long);
    @pokemons = crawler.parse
  end
end
