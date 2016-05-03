Rails.application.routes.draw do
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users, except: [:destroy]
  resources :categories, only: [:index] do
    resources :lessons, only: [:create, :show]
  end
  
  namespace :admin do
    resources :categories
  end
end
