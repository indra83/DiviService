class Update < ActiveRecord::Base
  has_paper_trail

  belongs_to :book

  validates :book_id, presence: true
  validates :status, presence: true
  validates :strategy, presence: true
  validates :book_version,  presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  after_save :build_book

  scope :latest, -> {
    order(:book_version)
  }

  scope :since, ->(v) { latest.where 'book_version >= ?', v }

  scope :rewrites, -> {
    where strategy: :replace
  }

  scope :live,    -> { where status: %w[live] }
  scope :staging, -> { where status: %w[live staging] }
  scope :testing, -> { where status: %w[live staging testing] }

  include Rails.application.routes.url_helpers

  def admin_path
    admin_book_update_path book, self
  end

private
  def build_book
    return unless strategy == 'replace'
    book.rebuild_version_caches
  end
end
