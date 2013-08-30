class Lecture < ActiveRecord::Base
  belongs_to :teacher, class_name: :User
  belongs_to :class_room
end
