Rails.application.routes.draw do
  get 'lessons/show'

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users, only: [:new, :create, :show]
  resources :categories, only: [:index] do
    resources :lessons, only: [:create, :show]
  end
end
