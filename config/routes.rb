Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'bike_shop#index'
  get '/bike-shop', to: 'accessories#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'

  resources :users, only: [:new, :create]

  resources :stations, only: [:index, :show]
end
