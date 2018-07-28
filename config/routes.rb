Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root :to => "home#index"
  authenticated :user do
    resources :logs
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
