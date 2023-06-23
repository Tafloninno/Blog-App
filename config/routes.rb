Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations' }

  root to: "users#index"

  resources :users do
    resources :posts do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
end
