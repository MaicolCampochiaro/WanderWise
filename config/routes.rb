Rails.application.routes.draw do
  devise_for :users
  root to: "locations#index"
  get '/locations' => 'locations#index'
  resources :trips

end
