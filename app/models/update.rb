class Update < ActiveRecord::Base
  has_paper_trail

  belongs_to :book

  validates :book_id, presence: true
  validates :status, presence: true
  validates :strategy, presence: true
  validates :book_version,  presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  ALLOWED_CATEGORIES_FOR_ROLE = {
    "student" => %w[live],
    "teacher" => %w[live staging],
    "tester" => %w[live staging testing]
  }.with_indifferent_access

  scope :recent_for, ->(book_version, role) {
    where(status: ALLOWED_CATEGORIES_FOR_ROLE[role]).
    where("book_version >= ?", book_version)
  }

  scope :latest, -> {
    order('book_version DESC')
  }

  scope :rewrites, -> {
    where strategy: :replace
  }

  include Rails.application.routes.url_helpers

  def admin_path
    admin_book_update_path book, self
  end
end
