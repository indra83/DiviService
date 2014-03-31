require 'spec_helper'

describe Account do
  subject(:account) { create :account, password: 'password', password_confirmation: 'password' }

  context 'after login' do
    before { account.authenticate 'password' }
    its(:token) {
      should_not be_nil
      should_not be_empty
    }
  end

end
