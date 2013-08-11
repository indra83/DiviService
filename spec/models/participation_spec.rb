require 'spec_helper'

describe Participation do
  let(:class_room) { create :class_room }
  let(:another_class_room) { create :class_room }
  let(:student) { create :user, role: :student, class_room: class_room }
  let(:teacher) { create :user, role: :teacher, class_room: class_room }

  it "should associate a student to only one class room" do
    participation = build :participation, user: student, class_room: another_class_room
    participation.save.should be_false
  end

  it "shoudl associats a teacher to more than one class rooms" do
    participation = build :participation, user: teacher, class_room: another_class_room
    participation.save.should be_true
  end

end
