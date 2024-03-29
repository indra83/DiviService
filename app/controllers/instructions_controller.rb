class InstructionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    @lecture = Lecture.find params[:lecture_id]
    render json: {error: {code: 401, message: "Unauthorized"} } unless @lecture && current_user.class_rooms.include?(@lecture.class_room)

    @instructions = @lecture.instructions.where("created_at > ?", Time.from_millistr(params[:since])).order('created_at DESC').limit(10)
  end

  def create
    @lecture = Lecture.find params[:lecture_id]
    render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher? && @lecture && @lecture.teacher == current_user

    if params[:command]
      @command = @lecture.class_room.commands.create command_params

      render json: {error: {code:422, message: "Some commands can not be created due to validation errors", errors: @command.errors} } if @command.errors.present?
    end

    @instruction = @lecture.instructions.create payload: params[:instruction]

    render json: {error: {code:422, message: "The instruction can not be created due to validation errors", errors: @instruction.errors} }  if @instruction.errors.present?

  end

private
  def command_params
    c = params.require(:command)
    c[:ends_at] = Time.from_millistr c[:ends_at]
    c[:applied_at] = Time.from_millistr c[:applied_at]
    c.permit!
  end
end
