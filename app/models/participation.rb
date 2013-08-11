class Participation < ActiveRecord::Base
  belongs_to :class_room
  belongs_to :user

  validates :class_room_id, presence: true
  validates :user_id, presence: true,
                      uniqueness: true
end
