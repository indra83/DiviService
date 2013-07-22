class SessionsController < ApplicationController
  def create
    @current_user = User.find_by_name params[:name]
    if @current_user && @current_user.authenticate(params[:password])
      session[:current_user_id] = @current_user.id
    else
      render json: {error: 'Authentication Failed'}, status: 401
    end
  end
end
