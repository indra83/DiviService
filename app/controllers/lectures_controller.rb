class LecturesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def create
    @lecture = Lecture.new teacher: @current_user, class_room_id: params[:classId], name: params[:name], start_time: Time.at(params[:startTime].to_i)

    render json: {error: {code:422, message: "The lecture can not be created due to validation errors", errors: @lecture.errors} }  unless @lecture.save
  end

  def index
    @lectures = @current_user.lectures
  end
end
