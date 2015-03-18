require 'rails_helper'

describe Lecture do
  subject(:lecture) { create :lecture }
  its(:status) { should == 'live' }

  it "should check if any lectures are live" do
    lecture.save
    expect(Lecture.all.any_live?).to eq true
  end

end
