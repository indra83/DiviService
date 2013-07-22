require 'spec_helper'

describe User do
  subject(:user) { create :user }
  its(:token) {
    should_not be_nil
    should_not be_empty
  }
end
