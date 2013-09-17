require 'spec_helper'

describe Lecture do
  subject(:lecture) { create :lecture }
  its(:status) { should == 'live' }

  it "should autoexpire in one hour" do
    lecture.start_time = 2.hours.ago
    lecture.computed_status.should == 'expired'
  end
end
