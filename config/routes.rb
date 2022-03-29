Rails.application.routes.draw do
  devise_for :users
  root "homes#top"
  get "/home/about" => "homes#about"
  resources :books, only: [:new, :create, :edit, :index, :show, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
end
