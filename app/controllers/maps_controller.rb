class MapsController < ApplicationController
  def index
    @pokemons = Pokemon.active.sort_by(&:pokemon_id)
  end
end
