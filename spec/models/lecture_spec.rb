require 'spec_helper'

describe Lecture do
  subject(:lecture) { create :lecture }
  its(:status) { should == 'live' }
end
