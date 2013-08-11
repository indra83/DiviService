require 'spec_helper'

describe Participation do
  let(:class_room) { create :class_room }
  let(:student) { create :user, role: :student, class_room: class_room }
  it "should associate a student to only one class room" do
    another_class_room = create :class_room
    participation = build :participation, user: student, class_room: another_class_room
    participation.save.should be_false

  end
end
