class Lecture < ActiveRecord::Base
  has_paper_trail

  belongs_to :teacher, class_name: :User
  belongs_to :class_room
	has_many :instructions, dependent: :destroy

  validates :teacher_id, presence: true
  validates :class_room_id, presence: true

  validate :teacher_has_no_other_live_lectures, on: :create
  validate :class_room_has_no_other_live_lectures, on: :create

  default_values  status: :live,
                  start_time: -> { Time.zone.now }

  scope :live, -> { where(status: 'live') }
  scope :old, -> { where('start_time < ?', 1.hour.ago) }

  delegate :members, to: :class_room

	def channel
		"lecture_#{id}"
	end

  def live?
    self.status == 'live'
  end

  LECTURE_END_INSTRUCTION_PAYLOAD = {type: 2, location: 'get lost'}.to_json
  def expire!
    update_attributes status: 'expired'

    instructions.create payload: LECTURE_END_INSTRUCTION_PAYLOAD
  end

  def self.any_live?
    live.any?
  end

private
  def teacher_has_no_other_live_lectures
    errors.add(:teacher, "can't create second live lecture without expiring the first.") if teacher.delivering_lectures.any_live?
  end

  def class_room_has_no_other_live_lectures
    errors.add(:class_room, "can't host second live lecture without expiring the first.") if teacher.delivering_lectures.any_live?
  end
end
