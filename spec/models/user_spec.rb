require 'spec_helper'

describe User do
  subject(:user) { create :user }
  its(:token) {
    should_not be_nil
    should_not be_empty
  }

  context "with class room" do
    let(:class_room) { create :class_room }
    subject(:student) { create :user, role: :student, class_rooms: [class_room] }

    its(:class_room) { should == class_room }

  end

  context "(student)" do
    subject(:student) { create :user, role: :student }

    its(:student?) { should be_true }
  end
end
