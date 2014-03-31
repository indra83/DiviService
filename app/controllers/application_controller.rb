class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :underscore_param_keys

  helper_method :account, :current_user
protected
  def current_user
    @current_user ||= account.try(:user)
  end

  def account
    @account ||= Account.find_by_token params[:token]
  end

  def authenticate_user
    render json: {error: 'Authentication Failed'}, status: 401 unless current_user
  end

  def user_for_paper_trail
    admin_user_signed_in? ? current_admin_user : 'Unknown user'
  end

  def underscore_param_keys
    params.deep_transform_keys! &:underscore
  end
end
