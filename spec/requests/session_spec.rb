require 'rails_helper'

describe "Session" do
  describe "POST /session" do
    let(:user) { create :user }
    let(:pattern) {
      {
        uid: user.id.to_s,
        token: user.token
      }.ignore_extra_keys!
    }

    it "should return a token for successful login" do
      post login_path(format: :json), %({"uid": "#{user.id}", "password": "#{user.password}"}), CONTENT_TYPE: 'application/json'
      user.reload
      response.body.should match_json_expression pattern
    end

    context "with google login" do
      let(:json_payload) {
        {
          googleID: "110833109878975856494",
          name: "blah blah",
          profilePic: "https://lh4.googleusercontent.com/-gHNF9cQ8M2M/AAAAAAAAAAI/AAAAAAAAAAA/lqHM3Rhw98Y/photo.jpg",
          role: "teacher"
        }
      }

      it "should login an existing user" do
        user.update_attributes google_id: json_payload[:googleID]
        post google_login_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'
        user.reload
        response.body.should match_json_expression pattern
      end

      it "should create a new user for missing google id" do
        create :class_room, id: 1
        json_payload[:googleID] = '12345678900987654321'
        post google_login_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'
        user = User.find_by_google_id json_payload[:googleID]
        pattern = {
          uid: user.id.to_s,
          token: user.token
        }.ignore_extra_keys!
        response.body.should match_json_expression pattern
      end
    end
  end
end
