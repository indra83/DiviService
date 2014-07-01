class Book < ActiveRecord::Base
  has_paper_trail

  belongs_to :course
  has_many :updates, dependent: :destroy

  validates :course_id, presence: true

  def full_name
    "#{course.name} - #{name}"
  end

  def pending_updates(version, branch)
    version ||= 0
    updates.send(branch).since([attributes["#{branch}_updates_start"], version + 1].max)
  end

  include Rails.application.routes.url_helpers

  def admin_path
    admin_book_path self
  end

  def rebuild_version_caches
    version_caches = Hash.new
    latest_rewrites = updates.rewrites.latest
    %w[live staging testing].each do |branch|
      version_caches["#{branch}_updates_start"] = latest_rewrites.send(branch).first.try :book_version
    end
    update_attributes version_caches
  end
end
