Rails.application.routes.draw do

  root 'home_pages#home'
  devise_for :users
  resources :users, only: [:show]
end
