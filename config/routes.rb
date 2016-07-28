Rails.application.routes.draw do
  require 'sidekiq/web'

  devise_for :users

  resources :maps

  get "refresh", to: "maps#refresh"

  mount Sidekiq::Web, at: '/sidekiq'
end
