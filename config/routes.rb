Rails.application.routes.draw do
  devise_for :users

  resources :categories, except: [:update, :edit]

  root "home#index"
end