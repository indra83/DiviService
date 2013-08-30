require 'spec_helper'

describe "Session" do
  describe "POST /session" do
    let(:user) { create :user }
    let(:pattern) do
      {
        uid: user.id,
        token: user.token
      }.ignore_extra_keys!
    end

    it "should return a token for successful login" do
      post login_path(format: :json), %({"uid": "#{user.id}", "password": "#{user.password}"}), CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end
  end
end


