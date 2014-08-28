class Lecture < ActiveRecord::Base
  has_paper_trail

  belongs_to :teacher, class_name: :User
  belongs_to :class_room

end
