class Update < ActiveRecord::Base
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
end
