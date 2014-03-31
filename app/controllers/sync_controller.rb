class SyncController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    @items = []
    @commands = []

	  @items = current_user.attempts.where('last_updated_at > ?', Time.at(params[:last_sync_time][:attempts].to_i)) if params[:last_sync_time][:attempts]
	  @commands = current_user.commands.where('updated_at > ?', Time.at(params[:last_sync_time][:commands].to_i)) if params[:last_sync_time][:commands]
  end

	def create
    @items_status = params[:attempts].map do |item_params|
      search_params = item_params.extract! :book_id, :assessment_id, :question_id
      search_params[:user_id] = current_user.id
      value_params = item_params.extract! :total_points, :attempts, :correct_attempts, :wrong_attempts, :subquestions, :data, :course_id
      value_params[:last_updated_at] = Time.at item_params[:last_updated_at].to_i if item_params[:last_updated_at]


      item = Attempt.where(search_params).first_or_initialize
      existing = item.persisted?
      item.update_attributes value_params

      return {error: {code:422, message: "The instruction can not be created due to validation errors", errors: item.errors} } if item.errors.present?
      { success: (existing ? 'updated' : 'created') }
    end

    render json: {last_sync_time: Time.now.to_i.to_s, status: @items_status}
	end
end
