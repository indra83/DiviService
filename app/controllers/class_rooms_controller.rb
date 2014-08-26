class LecturesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def members
    @class_room = ClassRoom.find params[:class_room_id]
    render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher? && @class_room && @class_room.users.include? current_user

    @members = @class_room.members
  end

end
