class UpdatesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    @class_room = current_user.class_rooms.first
  end
end
