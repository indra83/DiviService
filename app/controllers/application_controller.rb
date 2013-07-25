class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

protected
  def current_user
    @current_user ||= User.find_by_token params[:token]
  end

  def authenticate_user
    render json: {error: 'Authentication Failed'}, status: 404 unless current_user
  end

end
