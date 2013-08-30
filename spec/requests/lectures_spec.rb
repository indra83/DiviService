require 'spec_helper'

describe "Lecture" do
  describe "POST /lectures" do
    let(:class_room) { create :class_room }
    let(:teacher) { create :user, class_rooms: [class_room] }
    let(:json_payload) { %({"token": "#{teacher.token}", "classId": "#{class_room.id}", "name": "Test Lecture","startTime": "1376344044"}) }
    let(:pattern) do
      {
        id: :lecture_id,
        classId: class_room.id,
        name: "Test Lecture",
        teacherId: teacher.id,
        teacherName: teacher.name,
        channel: /^lecture_\d+$/,
        startTime: 1376344044
      }
    end

    it "should be successfully created by a teacher" do
     post create_lectures_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
     response.body.should match_json_expression pattern
    end
  end
end
