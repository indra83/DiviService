class School < ActiveRecord::Base
  has_paper_trail

  has_many :class_rooms, dependent: :destroy
	has_many :books, through: :class_rooms
	has_many :updates, through: :class_rooms
	has_many :users, through: :class_rooms
	has_many :cdns, dependent: :destroy


  validates :name, presence: true

end
