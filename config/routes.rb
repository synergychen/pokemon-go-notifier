Rails.application.routes.draw do
  require 'sidekiq/web'

  devise_for :users

  resources :maps

  mount Sidekiq::Web, at: '/sidekiq'
end
