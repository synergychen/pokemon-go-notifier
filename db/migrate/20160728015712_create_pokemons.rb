class CreatePokemons < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.integer :pokemon_id
      t.string :uid
      t.string :image_uri
      t.datetime :expire_at
      t.string :latitude
      t.string :longitude
      t.boolean :is_alive
      t.string :pokevision_uri
      t.string :area

      t.timestamps null: false
    end
  end
end
