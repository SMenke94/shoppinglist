Rails.application.routes.draw do
  devise_for :users
  resources :users, as: :admin_users, path: 'users'
  post 'create_user', to: 'users#create', as: 'create_user'

  resources :products do
    collection do
      patch :sort
    end
  end
  get 'send_product_mail/:id', to: 'products#send_product_mail', as: 'send_product_mail'
  
  root to: 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end