Rails.application.routes.draw do
  devise_for :users
  root to: 'coins#index'

  resources :coins, only: [:index]
end
