class Command < ActiveRecord::Base
  belongs_to :class_room
  belongs_to :teacher, class_name: :User
  belongs_to :course
  belongs_to :book
end
