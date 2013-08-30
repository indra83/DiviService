class ClassRoom < ActiveRecord::Base
  belongs_to :school
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :users

  validates :school_id, presence: true

  delegate :name, to: :school, prefix: true, allow_nil: true

  def name
    "#{standard} #{section} - #{school_name}"
  end
end
