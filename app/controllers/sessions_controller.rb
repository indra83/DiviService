class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @current_user = User.find params[:uid].to_i
    if @current_user && @current_user.authenticate(params[:password])
      session[:current_user_id] = @current_user.id
    else
      render json: {error: {code: 401, message: 'Authentication Failed'}}
    end
  end

  def autoprovision
    @current_user = Lab.find(params[:lab_id]).pop_pending_user

    if @current_user && @current_user.post_authenticate!
      render :create
    else
      render json: {error: {code: 404, message: 'No provisioning Session found for the tablet'}}
    end
  end
end
