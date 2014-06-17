require 'spec_helper'

describe User do
  subject(:user) { create :user, password: 'password', password_confirmation: 'password' }

  context 'after login' do
    before { user.authenticate 'password' }
    its(:token) {
      should_not be_nil
      should_not be_empty
    }
  end

  context "with class room" do
    let(:class_room) { create :class_room }
    subject(:student) { create :user, role: :student, class_rooms: [class_room] }

    its(:class_room) { should == class_room }

  end

  context "(student)" do
    subject(:student) { create :user, role: :student }

    its(:student?) { is_expected.to eq true }
  end
end
