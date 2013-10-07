class Update < ActiveRecord::Base
  has_paper_trail

  belongs_to :book

  validates :book_id, presence: true
  validates :status, presence: true
  validates :strategy, presence: true
  validates :version, presence: true,
                      numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  ALLOWED_CATEGORIES_FOR_ROLE = {
    "student" => %w[live],
    "teacher" => %w[live staging]
  }

  scope :recent_for, ->(version, role) {
    where(status: ALLOWED_CATEGORIES_FOR_ROLE[role]).
    where("version > ?", version)
  }

  scope :latest, -> { order('version DESC').limit(1) }

  include Rails.application.routes.url_helpers

  def admin_path
    admin_book_update_path book, self
  end
end
