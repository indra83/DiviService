class Book < ActiveRecord::Base
  has_paper_trail

  belongs_to :course
  has_many :updates, dependent: :destroy

  validates :course_id, presence: true

  def pending_updates(version = 0, branch = :live)
    updates.send(branch).since([attributes["#{branch}_updates_start"], version + 1].compact.max)
  end

  def rebuild_version_caches
    version_caches = Hash.new
    latest_rewrites = updates.rewrites.latest
    %w[live staging testing].each do |branch|
      version_caches["#{branch}_updates_start"] = latest_rewrites.send(branch).last.try :book_version
    end
    update_attributes version_caches
  end
end
