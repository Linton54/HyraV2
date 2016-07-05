Rails.application.routes.draw do

  root 'home_pages#home'
  devise_for :users

  resources :home_pages, as: 'category', path: 'category', param: :category, only: [:show, :home]
  resources :users, only: [:show]
  resources :posts
end
