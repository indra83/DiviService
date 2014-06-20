class SyncController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    @attempts = []
    @commands = []
    @has_more_data = false

    per_page = params[:items_per_page].to_i || 100

    if last_sync_times[:attempts]
      @attempts = current_user.attempts.paginated_latest(Time.from_millistr(last_sync_times[:attempts]), per_page)
      @has_more_data ||= @attempts.unscope(:limit).count > per_page
    end

    if last_sync_times[:commands]
	    @commands = current_user.commands.paginated_latest(Time.from_millistr(last_sync_times[:commands]), per_page)
      @has_more_data ||= @commands.unscope(:limit).count > per_page
    end
  end

	def create
    @items_status = params[:attempts].map do |item_params|
      search_params = item_params.extract! :book_id, :assessment_id, :question_id
      search_params[:user_id] = current_user.id
      value_params = item_params.permit :total_points, :attempts, :correct_attempts, :wrong_attempts, :subquestions, :data, :course_id
      value_params[:last_updated_at] = Time.from_millistr item_params[:last_updated_at] if item_params[:last_updated_at]
      value_params[:solved_at] = Time.from_millistr item_params[:solved_at] if item_params[:solved_at]


      item = Attempt.where(search_params).first_or_initialize
      existing = item.persisted?
      item.update_attributes value_params

      if item.errors.present?
       :error
      else
        existing ? :updated : :created
      end
    end

    render json: {last_sync_time: Time.now.to_millistr, status: @items_status}
	end

  def scores
    render json: {error: {code: 401, message: "Unauthorized"} } unless current_user.teacher?

    @attempts = Attempt.where query_params
  end

private
  def query_params
    params[:user_id] = params.delete :student_id
    keys =[:user_id, :course_id, :book_id, :assessment_id]
    keys.each {|key| params.require key}

    params.slice *keys
  end

  def last_sync_times
    params.require :last_sync_time
  end
end
