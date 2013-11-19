class SyncController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
		@items = current_user.sync_items
		@items = @items.where('updated_at > ?', Time.at(params[:last_sync_time].to_i)) if params[:last_sync_time]
  end

	def create
    @items_status = params[:sync_items].map do |item_params|
      search_params = item_params.extract! :book_id, :assessment_id, :question_id
      search_params[:user_id] = current_user.id
      value_params = item_params.extract! :total_points, :attempts, :correct_attempts, :wrong_attempts, :subquestions, :data, :last_updated_at


      item = SyncItem.where(search_params).first_or_initialize
      existing = item.persisted?
      item.update_attributes value_params

      return {error: {code:422, message: "The instruction can not be created due to validation errors", errors: item.errors} } if item.errors.present?
      { success: (existing ? 'updated' : 'created') }
    end

    render json: {last_sync_time: Time.now.to_i.to_s, status: @items_status}
	end

  def dashboard
    @sync_items = SyncItem.where(
      assessment_id: params[:assessment_id],
      book_id: params[:book_id],
      user_id: ClassRoom.find(params[:class_id]).users.map(&:id)
    )

    @students_points = @sync_items.group_by &:user_id
    @questions_points = @sync_items.group_by &:question_id
  end
end
