class UpdatesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    @class_rooms = current_user.class_rooms
    @updates = @class_rooms.
      flatten.map(&:courses).
      flatten.map(&:books).
      flatten.map { |book|
        version_def_for_book = params["versions"] && params["versions"].select {|version| version["bookId"] == book.id.to_s }.first
        present_version = version_def_for_book && version_def_for_book["version"].to_i || 0
        book.updates.recent_for(present_version, @current_user.role)
      }.flatten
  end
end
