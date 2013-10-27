class SyncController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
		#@lecture = Lecture.find params[:lectureId]
		#render json: {error: {code: 401, message: "Unauthorized"} } unless @lecture && current_user.class_rooms.include?(@lecture.class_room)

    #@instructions = @lecture.instructions.where("created_at > ?", Time.at(params[:since].to_i))
  end

	def create
    @items_status = params[:sync_items].map do |item_params|
      search_params = item_params.extract! :user_id, :book_id, :assessment_id, :question_id
      value_params = item_params.extract! :points, :attempts, :data, :last_updated_at

      item = SyncItem.where(search_params).first_or_initialize
      existing = item.persisted?
      item.update_attributes value_params

      return {error: {code:422, message: "The instruction can not be created due to validation errors", errors: item.errors} } if item.errors.present?
      { success: (existing ? 'updated' : 'created') }
    end

    render json: {last_sync_time: Time.now.to_i.to_s, status: @items_status}
	end
end
