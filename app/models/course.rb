class Course < ActiveRecord::Base
  has_paper_trail

  has_and_belongs_to_many :class_rooms
  has_many :books, dependent: :destroy

	has_many :updates, through: :books

end
