class Lab < ActiveRecord::Base
  belongs_to :school
  has_many :tablets

  attr_accessor :class_room
  def class_room
    User.find_by_id(pending_user_ids.try(:first)).try(:class_room)
  end

  def class_room=(value)
    self.pending_user_ids = ClassRoom.find(value).users.students.pluck(:id)
  end

  def pop_pending_user
    User.find pop_user_id
  end
private
  def pop_user_id
    user_id = pending_user_ids.shift
    save
    user_id
  end
end
