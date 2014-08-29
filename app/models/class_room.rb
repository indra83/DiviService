class ClassRoom < ActiveRecord::Base
  has_paper_trail

  belongs_to :school
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :users
  has_many :lectures, dependent: :destroy
	has_many :books, through: :courses
	has_many :updates, through: :courses
  has_many :commands, dependent: :destroy

  validates :school_id, presence: true

  delegate :name, to: :school, prefix: true, allow_nil: true

  alias_method :members, :users
end
