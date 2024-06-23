Rails.application.routes.draw do
  get 'films/index'
  get 'films/show'
  get 'vehicles/index'
  get 'vehicles/show'
  get 'planets/index'
  get 'planets/show'
  get 'people/index'
  get 'people/show'
  root 'home#index'

  resources :people, only: [:index, :show]
  resources :planets, only: [:index, :show]
  resources :films, only: [:index, :show]
  resources :vehicles, only: [:index, :show]
  resources :starships, only: [:index, :show]
end