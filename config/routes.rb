Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'bike_shop#index'
  get '/bike-shop', to: 'accessories#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'

  resources :users, only: [:new, :create]

  resources :accessories, only: [:index, :show]
  resources :stations, only: [:index, :show]

  resources :orders, only: [:show]

  namespace :admin do
    get '/bikeshop/new', to: 'accessories#new'
    resources :accessories
  end

  resources :trips, only: [:index, :show]
end
