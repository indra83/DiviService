DiviService::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #resource :session

  # V1 routes
  scope '/v1', defaults: { format: :json } do
    post "loginUser",         to: 'sessions#create',     as: :login
    post "getContentUpdates", to: 'updates#index',       as: :content_updates
    post "getCacheUpdates",   to: 'cdns#create',         as: :cache_updates
    post "createLecture",     to: 'lectures#create',     as: :create_lectures
    post "getLectures",       to: 'lectures#index',      as: :lectures
    post "endLecture",        to: 'lectures#destroy',    as: :end_lecture
    post "getLectureMembers", to: 'lectures#members',    as: :lecture_members
    post "sendInstruction",   to: 'instructions#create', as: :create_instructions
    post "getInstructions",   to: 'instructions#index',  as: :instructions
    post "syncUp",            to: 'sync#create',         as: :sync_up
    post "syncDown",          to: 'sync#index',          as: :sync_down
  end

  root to: 'admin/dashboard#index'

  post "/temp/dashboard", to: 'sync#dashboard', as: :dashboard
end
