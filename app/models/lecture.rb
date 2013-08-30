class Lecture < ActiveRecord::Base
  belongs_to :teacher, class_name: :User
  belongs_to :class_room

  validates :teacher_id, presence: true
  validates :class_room_id, presence: true
end
