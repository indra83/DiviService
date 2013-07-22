DiviService::Application.routes.draw do
  resource :session

  # V1 routes
  namespace :v1 do
    post "loginUser", to: 'sessions#create', as: :login, defaults: { format: 'json' }
  end
end
