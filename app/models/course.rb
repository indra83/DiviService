class Course < ActiveRecord::Base
  has_and_belongs_to_many :class_rooms
  has_many :books
end
