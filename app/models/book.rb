class Book < ActiveRecord::Base
  belongs_to :course
  has_many :updates, dependent: :destroy

  validates :course_id, presence: true

  def full_name
    "#{course.name} - #{name}"
  end
end
