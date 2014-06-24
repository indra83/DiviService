class Lecture < ActiveRecord::Base
  has_paper_trail

  belongs_to :teacher, class_name: :User
  belongs_to :class_room
	has_many :instructions, dependent: :destroy

  validates :teacher_id, presence: true
  validates :class_room_id, presence: true

  validate :teacher_has_no_other_live_lectures, on: :create
  validate :class_room_has_no_other_live_lectures, on: :create

  before_validation :set_status
  before_validation :set_start_time

  # scope :live, where(status: 'live')
  def self.live
    where(status: 'live').select &:live?   # Remove this when cron job or other means is introduced to persist autoexpiry
  end


  delegate :members, to: :class_room

	def channel
		"lecture_#{id}"
	end

  def computed_status
    start_time < 1.hour.ago ? 'expired' : status
  end

  def live?
    computed_status == 'live'
  end

  LECTURE_END_INSTRUCTION_PAYLOAD = {type: 2, location: 'get lost'}.to_json
  def expire!
    update_attributes status: 'expired'

    instructions.create payload: LECTURE_END_INSTRUCTION_PAYLOAD
  end

  def self.any_live?
    live.present?
  end

private
  def set_status
    self.status ||= 'live'
  end

  def set_start_time
    self.start_time ||= Time.now
  end

  def teacher_has_no_other_live_lectures
    errors.add(:teacher, "can't create second live lecture without expiring the first.") if teacher.delivering_lectures.any_live?
  end

  def class_room_has_no_other_live_lectures
    errors.add(:class_room, "can't host second live lecture without expiring the first.") if teacher.delivering_lectures.any_live?
  end
end
