class InstructionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

	def create
		lecture = Lecture.find params[:lectureId]
		render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher? && lecture && lecture.teacher == current_user
		@instruction = lecture.instructions.create payload: params[:instruction]

    render json: {error: {code:422, message: "The instruction can not be created due to validation errors", errors: @instruction.errors} }  if @instruction.errors.present?

		render json: "OK"
	end
end
