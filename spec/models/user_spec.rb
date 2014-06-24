require 'spec_helper'

describe User do
  subject(:user) { create :user, password: 'password', password_confirmation: 'password' }

  context 'after login' do
    before { user.authenticate 'password' }
    its(:token) {
      is_expected.not_to be_nil
      is_expected.not_to be_empty
    }
    its(:report_starts_at) {
      is_expected.not_to be_nil
      is_expected.to be_within(2.seconds).of(Time.zone.now)
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
