class LecturesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    @lectures = @current_user.lectures.live
  end

  def create
    @lecture = Lecture.create lecture_params

    render json: {error: {code:422, message: "The lecture can not be created due to validation errors", errors: @lecture.errors} }  if @lecture.errors.present?
  end

  def destroy
    @lecture = Lecture.find params[:lecture_id]
    render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher? && @lecture && @lecture.teacher == current_user
    @lecture.update_attributes status: 'expired'

    render json: {error: {code:422, message: "The lecture can not be expired due to validation errors", errors: @lecture.errors} } and return if @lecture.errors.present?

    if params[:instruction]
      @instruction = @lecture.instructions.create payload: params[:instruction]
      render json: {error: {code:422, message: "The instruction can not be published due to validation errors.(The lecture has been expired)", errors: @instruction.errors} } and return if @instruction.errors.present?
    end
  end

  def members
    @lecture = Lecture.find params[:lecture_id]
    render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher? && @lecture && @lecture.teacher == current_user

    @members = @lecture.members
  end

private

  def lecture_params
    p = params.permit :class_room_id, :name
    p[:start_time] = Time.from_millistr params[:start_time] if params[:start_time]
    p[:teacher] = @current_user
    p
  end
end
