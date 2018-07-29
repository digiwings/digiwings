Rails.application.routes.draw do

  root :to => "home#index"

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  authenticated :user do
    resources :logs
    resources :flights
  end

  mount_griddler('/email/inbound')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
