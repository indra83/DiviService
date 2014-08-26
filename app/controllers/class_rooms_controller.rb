class ClassRoomsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def members
    @class_room = ClassRoom.find params[:class_room_id]
    render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher? && @class_room && @class_room.users.include?(current_user)

    @members = @class_room.members
  end

private

  def class_room_params
    p = params.permit :class_room_id, :name
    p[:start_time] = Time.from_millistr params[:start_time] if params[:start_time]
    p[:teacher] = @current_user
    p
  end
end
