class Lecture < ActiveRecord::Base
  belongs_to :teacher, class_name: :User
  belongs_to :class_room
	has_many :instructions

  validates :teacher_id, presence: true
  validates :class_room_id, presence: true

	def channel
		"lecture_#{id}"
	end
end
