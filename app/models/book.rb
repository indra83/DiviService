class Book < ActiveRecord::Base
  belongs_to :course
  has_many :updates

  validates :course_id, presence: true
end
