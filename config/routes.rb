Rails.application.routes.draw do

  root 'home_pages#home'
  devise_for :users
  resources :users, only: [:show]
  resources :posts, only: [:index, :create, :destroy]
end
