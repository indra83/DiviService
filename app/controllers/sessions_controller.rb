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

  def google
    @current_user = User.where(google_id: params[:google_id])
                        .first_or_initialize(class_room_ids: [1])
    @current_user.assign_attributes google_params

    if @current_user.save
      render :create
    else
binding.pry
      render json: {
        error: {
          code:     422,
          message:  'Error while creating/updating the user',
          errors:   @current_user.errors
        }
      }
    end
  end

private
  def google_params
    @google_params ||=  params.permit :google_id, :name, :profile_pic, :role
  end
end
