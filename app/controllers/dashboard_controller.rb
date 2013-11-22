class DashboardController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def score
    sync_items = SyncItem.where(
      assessment_id: params[:assessment_id],
      book_id: params[:book_id],
      user_id: ClassRoom.find(params[:class_id]).users.map(&:id)
    )

    @scores_by_student = DashboardScoreCalculator.new sync_items, :user_id
    @scores_by_question = DashboardScoreCalculator.new sync_items, :question_id
  end
end
