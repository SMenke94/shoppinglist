require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :users, as: :admin_users, path: 'users'
  post 'create_user', to: 'users#create', as: 'create_user'

  resources :products do
    collection do
      patch :sort
    end
    member do
      post 'send_product_mail'
    end
  end

  root to: 'products#index'

  mount Sidekiq::Web => '/sidekiq'
end
