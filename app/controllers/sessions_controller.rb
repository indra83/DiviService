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
    @tablet = Tablet.find(params[:tab_id])
    lab_update = @tablet.lab.tap { |lab|
      session[:current_user_id] = lab.pending_user_ids.shift
    }.save

    @current_user = User.find_by_id session[:current_user_id]

    if @current_user && @current_user.post_authenticate!
      render :create
    else
      render json: {error: {code: 404, message: 'No provisioning Session found for the tablet'}}
    end
  end
end
