Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'bike_shop#index'
  get '/bike-shop', to: 'accessories#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'
  get 'admin/dashboard', to: 'users#show'
  get '/stations-dashboard', to:'stations#dashboard'
  get '/trips-dashboard', to: 'trips#dashboard'

  get '/cart', to: 'carts#show'
  delete '/carts', to: 'carts#destroy'
  patch '/carts', to: 'carts#update'

  resources :users, only: [:new, :create, :edit, :show, :update]

  resources :accessories, only: [:show]
  resources :stations, only: [:index, :show]

  resources :orders, only: [:show]
  resources :carts, only: [:create, :update]


  namespace :admin do
    get '/bikeshop/new', to: 'accessories#new'
    get '/bike-shop', to: 'accessories#index'
    resources :stations
    resources :accessories, only: [:show, :edit, :create, :destroy, :update]
    resources :orders, only: [:update]
    resources :trips
  end

  resources :trips, only: [:index, :show]
end
