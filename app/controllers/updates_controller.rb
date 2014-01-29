class UpdatesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def index
    @class_rooms = current_user.class_rooms
    @updates = current_user.books.map { |book|
        version_def_for_book = params["versions"] && params["versions"].select {|version| version["bookId"] == book.id.to_s }.first
        present_version = version_def_for_book && version_def_for_book["version"].to_i || 0
        latest_rewrite = book.updates.rewrites.order('book_version DESC').first
        required_version = [(latest_rewrite && latest_rewrite.book_version || 0), present_version + 1].max
        book.updates.recent_for(required_version, @current_user.role).order('book_version ASC')
      }.flatten

    @cdns = @current_user.school.cdns.where("pinged_at >= ?", 30.minutes.ago).map(&:base_url)
  end
end
