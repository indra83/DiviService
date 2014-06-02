class Book < ActiveRecord::Base
  has_paper_trail

  belongs_to :course
  has_many :updates, dependent: :destroy

  validates :course_id, presence: true

  def full_name
    "#{course.name} - #{name}"
  end

  def pending_updates(version, role)
    version ||= 0
    latest_rewrite = updates.rewrites.order('book_version DESC').first
    required_version = [(latest_rewrite && latest_rewrite.book_version || 0), version + 1].max
    updates.recent_for(required_version, role).order('book_version ASC')
  end

  include Rails.application.routes.url_helpers

  def admin_path
    admin_book_path self
  end
end
