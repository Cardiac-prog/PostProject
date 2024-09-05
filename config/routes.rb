Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: "api/v1/sessions"  # For API requests
      }
      resources :posts, only: [ :index, :show, :create, :update, :destroy ]
    end
  end
  root "posts#index"

  resources :posts do
    resources :comments
  end
end
