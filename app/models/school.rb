class School < ActiveRecord::Base
  has_many :class_rooms
	has_many :updates, through: :class_rooms
	has_many :users, through: :class_rooms
	has_many :cdns


  validates :name, presence: true
end
