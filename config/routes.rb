Rails.application.routes.draw do
  devise_for :users
  root to: "trips#homepage", as: :homepage
  get '/locations/:id' => 'locations#index', as: :locations
  resources :trips, except: [:update] do
    resources :flights, only: [:index, :create], as: :flights
    resources :hotels, only: [:index, :create, :show], as: :hotels
    resources :activities, only: [:index, :create, :show], as: :activities
  end
  get '/trips/:id/:query' => 'trips#show', as: 'overview'
  post '/trips' => 'trips#create', as: 'create'
  post '/trips/:id/flights/'=> 'trips#flight_create', as: 'flight_create'
end
