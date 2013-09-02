module Student
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :class_rooms
    has_many :lectures, through: :class_rooms
    has_many :books, through: :class_rooms
    has_many :updates, through: :class_rooms


    validates :class_rooms, length: {
      minimum: 1,
      too_short: "must include atleast one participation."
    }

    validates :class_rooms, length: { maximum: 1 },
                            if: :student?
  end

  def student?
    role.to_s == 'student'
  end

  def class_room
    class_rooms.first
  end

  delegate :school, to: :class_room, allow_nil: true
	delegate :name, to: :school, allow_nil: true, prefix: true
end

