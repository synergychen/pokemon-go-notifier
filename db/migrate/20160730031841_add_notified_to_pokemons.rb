class AddNotifiedToPokemons < ActiveRecord::Migration
  def change
    add_column :pokemons, :notified, :boolean, default: false
  end
end
