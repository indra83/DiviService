class Book < ActiveRecord::Base
  has_paper_trail

  belongs_to :course
  has_many :updates, dependent: :destroy

  validates :course_id, presence: true

  def full_name
    "#{course.name} - #{name}"
  end

  include Rails.application.routes.url_helpers

  def admin_path
    admin_book_path self
  end
end
