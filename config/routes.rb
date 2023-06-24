# config/routes.rb
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index, :show] do
          resources :comments, only: [:create]
        end
      end
    end
  end

  devise_for :users, controllers: { confirmations: 'users/confirmations' }

  root to: "users#index"

  resources :users do
    resources :posts do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
end
