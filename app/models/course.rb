class Course < ActiveRecord::Base
  belongs_to :class_room
  has_many :books

  validates :class_room_id, presence: true
end
