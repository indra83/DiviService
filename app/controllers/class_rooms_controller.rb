class ClassRoomsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def create
    render json: {error: {code: 401, message: "Unauthorized"} } and return unless current_user.teacher?

    @class_room = current_user.class_rooms.create class_room_params

    render json: {error: {code:422, message: "The class_room can not be created due to validation errors", errors: @class_room.errors} } and return if @class_room.errors.present?
    render 'sessions/create'
  end

  def members
    @class_room = ClassRoom.find params[:class_room_id]
    render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher? && @class_room && @class_room.users.include?(current_user)

    @members = @class_room.members
  end

private

  def class_room_params
    p = params.permit :standard, :section
    p[:school_id] ||= 1
    p
  end
end
