class LecturesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    @lectures = @current_user.lectures.live
  end

  def create
    @lecture = Lecture.new teacher: @current_user, class_room_id: params[:classId], name: params[:name], start_time: Time.at(params[:startTime].to_i)

    render json: {error: {code:422, message: "The lecture can not be created due to validation errors", errors: @lecture.errors} }  unless @lecture.save
  end

  def destroy
    @lecture = Lecture.find params[:lectureId]
		render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher? && @lecture && @lecture.teacher == current_user
    @lecture.update_attributes status: 'expired'

    render json: {error: {code:422, message: "The lecture can not be expired due to validation errors", errors: @lecture.errors} } and return if @instruction.errors.present?

    instruction = @lecture.instructions.create payload: params[:instruction]
    render json: {error: {code:422, message: "The instruction can not be published due to validation errors.(The lecture has been expired)", errors: instruction.errors} } and return if instruction.errors.present?

    render json: "OK"
  end
end
