DiviService::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resource :session

  # V1 routes
  namespace :v1 do
    post "loginUser", to: 'sessions#create', as: :login, defaults: { format: 'json' }
  end
end
