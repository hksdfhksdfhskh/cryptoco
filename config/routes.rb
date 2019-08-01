Rails.application.routes.draw do
  root to: 'coins#index'

  devise_for :users,
    controllers: {
      omniauth_callbacks: "callbacks"
    }

  resources :coins, only: [:index]
end
