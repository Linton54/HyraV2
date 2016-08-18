Rails.application.routes.draw do

  root 'home_pages#home'

  resources :home_pages, as: 'category', param: :category, path: 'category', only: [:show, :home]

  devise_for :users
  resources :users, only: [:show, :index]
  resources :posts do
    resources :comments, only: [:create, :destroy, :index]
  end
  resources :relationships, only: [:create, :destroy]
  resources :search_suggestions, only: [:index]
  resources :messages, only: [:create, :destroy]
  resources :inboxes, only: [:create, :destroy]
end
