require 'spec_helper'

describe User do
  subject(:user) { create :user }
  its(:token) {
    should_not be_nil
    should_not be_empty
  }

  context "with class room" do
    subject(:student) { create :user, role: :student }
    let(:class_room) { create :class_room, user: student }

    its(:class_room) { should eq class_room }

  end

  context "(student)" do
    subject(:student) { create :user, role: :student }

    its(:student?) { should be_true }
  end
end
