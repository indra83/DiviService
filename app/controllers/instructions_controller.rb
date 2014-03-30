class InstructionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    @lecture = Lecture.find params[:lecture_id]
    render json: {error: {code: 401, message: "Unauthorized"} } unless @lecture && current_user.class_rooms.include?(@lecture.class_room)

    @instructions = @lecture.instructions.where("created_at > ?", Time.at(params[:since].to_i))
  end

  def create
    @lecture = Lecture.find params[:lecture_id]
    render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher? && @lecture && @lecture.teacher == current_user
    @instruction = @lecture.instructions.create payload: params[:instruction]

    render json: {error: {code:422, message: "The instruction can not be created due to validation errors", errors: @instruction.errors} }  if @instruction.errors.present?

    @commands = @lecture.class_room.users.students.map do |student|
      student.commands.create params[:command]
    end

    errors = @commands.select {|c| c.errors.present?}
    render json: {error: {code:422, message: "Some commands can not be created due to validation errors", errors: errors} } if errors.present?

  end
end
