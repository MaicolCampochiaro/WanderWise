Rails.application.routes.draw do
  devise_for :users
  root to: "trips#homepage", as: :homepage
  get '/locations/:id' => 'locations#index', as: :locations
  get '/location/:id' => 'locations#create_location', as: 'create_location'
  resources :trips, except: [:update] do
    resources :flights, only: [:index, :new, :create], as: :flights
    resources :hotels, only: [:index, :create, :show], as: :hotels
    resources :activities, only: [:index, :create, :show], as: :activities
  end
  get '/trips/:trip_id/:query' => 'trips#show', as: 'overview'
  post '/trips' => 'trips#create', as: 'create'
  get '/trips/:trip_id/hotels/:hotel_id' => 'hotels#show', as: 'hotel_show'
end
