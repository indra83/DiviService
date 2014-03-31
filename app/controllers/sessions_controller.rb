class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @account = Account.find params[:uid].to_i
    unless account && account.authenticate(params[:password])
      render json: {error: {code: 401, message: 'Authentication Failed'}}
    end
  end
end
