module Student
  extend ActiveSupport::Concern

  included do
    has_one :participation
    has_one :class_room, through: :participation
  end
end

