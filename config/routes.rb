Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"

  resources :users do
    resources :posts do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
end
