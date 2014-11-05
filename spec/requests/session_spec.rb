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
        schoolLocation: String,
        schoolName: String,
        time: String,
        classRooms: user.class_rooms.map { |class_room|
          {
            classId: class_room.id.to_s,
            className: class_room.standard,
            section: class_room.section,
            courses: class_room.courses.map { |course|
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
      response.body.should match_json_expression pattern
    end
  end
end
