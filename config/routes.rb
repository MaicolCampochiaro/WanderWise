Rails.application.routes.draw do
  devise_for :users
  root to: "trips#homepage", as: :homepage
  get '/locations/:id' => 'locations#index', as: :locations
  resources :trips do

    resources :flights, only: [:index], as: :flights
    resources :hotels, only: [:index, :show], as: :hotels
    resources :activities, only: [:index, :show], as: :activities
  end
  get '/trips/:id' => 'trips#index', as: 'overview'
  post '/trips' => 'trips#create', as: 'create'
end
