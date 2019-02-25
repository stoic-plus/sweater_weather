Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/gifs', to: "gifs#show"
      get '/forecast', to: "forecast#show"
      get '/backgrounds', to: "background#show"
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :favorites, only: [:index, :create]
      delete 'favorites', to: "favorites#destroy"
    end
  end
end
