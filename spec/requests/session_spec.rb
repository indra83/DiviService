require 'rails_helper'

describe "Session" do
  describe "POST /session" do
    let(:user) { create :user }
    let(:pattern) {
      {
        uid: user.id.to_s,
        token: user.token,
        metadata: user.metadata,
        name: user.name,
        profilePic: user.pic,
        reportStartsAt: String,
        role: user.role,
        # schoolLocation: String,
        schoolName: String,
        time: String,
        classRooms: user.class_rooms.map { |class_room|
          {
            classId:            class_room.id.to_s,
            className:          class_room.standard,
            section:            class_room.section,
            allowedAppPackages: class_room.allowed_app_packages,

            courses:            class_room.courses.map { |course|
              {
                id: course.id.to_s,
                name: course.name
              }
            }
          }
        }
      }
    }

    it "should return a token for successful login" do
      post login_path(format: :json), %({"uid": "#{user.id}", "password": "#{user.password}"}), CONTENT_TYPE: 'application/json'
      user.reload
      expect(response.body).to match_json_expression pattern
    end

    context 'when auto provisioning' do
      let(:lab) {create :lab, pending_user_ids: [user.id]}

      it "should provision the user on tablet" do
        payload = %({"lab_id": "#{lab.id}"})
        post autoprovision_path(format: :json), payload , CONTENT_TYPE: 'application/json'
        user.reload
        expect(response.body).to match_json_expression pattern
      end
    end
  end
end
