class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @current_user = User.find params[:uid]
    if @current_user && @current_user.authenticate(params[:password])
      session[:current_user_id] = @current_user.id
    else
      render json: {error: {code: 401, message: 'Authentication Failed'}}
    end
  end
end
