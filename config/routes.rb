Rails.application.routes.draw do
  devise_for :users
  root to: "locations#index"
  get '/locations' => 'locations#index'
  resources :trips do
    resources :flights, only: [:index], as: :flights
    resources :hotels, only: [:index, :show], as: :hotels
    resources :activities, only: [:index, :show], as: :activities
  end

end
