DiviService::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #resource :session

  # V1 routes
  scope '/v1', defaults: { format: :json } do
    post "loginUser", to: 'sessions#create', as: :login
    post "getContentUpdates", to: 'updates#index', as: :content_updates
    post "createLecture", to: 'lectures#create', as: :create_lectures
    post "getLectures", to: 'lectures#index', as: :lectures
		post "sendInstruction", to: 'instructions#create', as: :create_instuctions
		post "getInstructions", to: 'instructions#index', as: :instuctions
  end

  root to: 'admin/dashboard#index'
end
