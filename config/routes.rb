Rails.application.routes.draw do
  get 'about_pages/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'species/index'
  get 'species/show'
  get 'starships/index'
  get 'starships/show'
  get 'films/index'
  get 'films/show'
  get 'vehicles/index'
  get 'vehicles/show'
  get 'planets/index'
  get 'planets/show'
  get 'people/index'
  get 'people/show'
  get '/about', to: 'about_pages#show'
  root 'home#index'


  resources :people, only: [:index, :show]
  resources :planets, only: [:index, :show]
  resources :films, only: [:index, :show]
  resources :vehicles, only: [:index, :show]
  resources :starships, only: [:index, :show]
  resources :species, only: [:index, :show]
  resources :jedis 
end