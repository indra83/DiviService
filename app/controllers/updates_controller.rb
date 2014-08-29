class UpdatesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    @class_rooms = current_user.class_rooms
    @updates = current_user.pending_updates params["versions"]
    @cdns = @current_user.school.cdns.where("pinged_at >= ?", 30.minutes.ago).map(&:base_url)
  end
end
