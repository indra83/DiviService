class LecturesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    @lectures = @current_user.lectures.live
  end

  def create
    @lecture = Lecture.create teacher: @current_user, class_room_id: params[:class_id], name: params[:name], start_time_stamp: param_start_time

    render json: {error: {code:422, message: "The lecture can not be created due to validation errors", errors: @lecture.errors} }  if @lecture.errors.present?
  end

  def destroy
    @lecture = Lecture.find params[:lecture_id]
    render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher? && @lecture && @lecture.teacher == current_user
    @lecture.update_attributes status: 'expired'

    render json: {error: {code:422, message: "The lecture can not be expired due to validation errors", errors: @lecture.errors} } and return if @lecture.errors.present?

    @instruction = @lecture.instructions.create payload: params[:instruction]
    render json: {error: {code:422, message: "The instruction can not be published due to validation errors.(The lecture has been expired)", errors: @instruction.errors} } and return if @instruction.errors.present?
  end

  def members
    @lecture = Lecture.find params[:lecture_id]
    render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher? && @lecture && @lecture.teacher == current_user

    @members = @lecture.members
  end

private

  def param_start_time
    params[:start_time].to_i if params[:start_time]
  end
end
