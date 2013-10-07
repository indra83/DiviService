class Course < ActiveRecord::Base
  has_paper_trail

  has_and_belongs_to_many :class_rooms
  has_many :books, dependent: :destroy

	has_many :updates, through: :books

  include Rails.application.routes.url_helpers

  def admin_path
    admin_course_path self
  end
end
