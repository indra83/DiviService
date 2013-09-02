class School < ActiveRecord::Base
  has_many :class_rooms
	has_many :updates, through: :class_rooms

  validates :name, presence: true
end
