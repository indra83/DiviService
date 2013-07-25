require 'spec_helper'

describe "Session" do
  describe "POST /session" do
    let(:user) { create :user }
    let(:pattern) do
      {
        id: user.id,
        token: user.token
      }
    end

    it "should return a token for successful login" do
      post login_path(format: :json), %({"name": "#{user.name}", "password": "#{user.password}"}), CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end
  end
end


