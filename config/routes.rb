Rails.application.routes.draw do
  devise_for :users

  root to: "trips#homepage", as: :homepage
  get '/locations/:id' => 'locations#index', as: :locations
  get '/location/:id' => 'locations#create_location', as: 'create_location'
  resources :trips, except: [:update]
  get '/trips/:id/flights' => 'flights#index', as: 'trip_flights'
  get '/trips/:id/flights/new' => 'flights#new', as: 'new_trip_flight'
  get '/trips/:id/hotels' => 'hotels#index', as: 'trip_hotels'
  get '/trips/:id/hotels/new' => 'hotels#new', as: 'new_trip_hotel'
  get '/trips/:id/hotels/:hotel_id' => 'hotels#show', as: 'hotel_show'
  get '/trips/:id/activities' => 'activities#index', as: 'trip_activities'
  get '/trips/:id/activities/new' => 'activities#new', as: 'new_trip_activity'
  post '/trips/:id/activities' => 'activities#create'
  get '/trips' => 'trips#index', as: 'my_trips'
  get '/trips/:id/:query' => 'trips#show', as: 'overview'
  post '/trips' => 'trips#create', as: 'create'
end
