class ClassRoom < ActiveRecord::Base
  belongs_to :school
  has_and_belongs_to_many :courses

  validates :school_id, presence: true
end
