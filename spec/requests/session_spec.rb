require 'spec_helper'

describe "Session" do
  describe "POST /session" do
    let(:account) { user.account }
    let(:user) { create :user }
    let(:pattern) {
      {
        uid: account.id.to_s,
        token: account.token
      }.ignore_extra_keys!
    }

    it "should return a token for successful login" do
      post login_path(format: :json), %({"uid": "#{account.id}", "password": "#{account.password}"}), CONTENT_TYPE: 'application/json'
      account.reload
      response.body.should match_json_expression pattern
    end
  end
end


