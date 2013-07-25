class Course < ActiveRecord::Base
  belongs_to :class_room
  has_many :books
end
