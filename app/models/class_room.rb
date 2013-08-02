class ClassRoom < ActiveRecord::Base
  belongs_to :school
  has_many :courses

  validates :school_id, presence: true
end
