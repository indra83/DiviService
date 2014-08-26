class UpdatesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    if params[:tablet]
      @tablet = Tablet.where(device_id: tablet_params.delete(:device_id)).first_or_initialize
      @tablet.update_attributes tablet_params
    end

    @class_rooms = current_user.class_rooms
    @updates = current_user.pending_updates params["versions"]
    @cdns = @current_user.school.cdns.where("pinged_at >= ?", 30.minutes.ago).map(&:base_url)
  end

private
  def tablet_params
    @tablet_params ||= params.require(:tablet).permit!
  end
end
