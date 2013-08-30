require 'spec_helper'

describe "Lecture" do
  describe "POST /lectures" do
    let(:class_room) { create :class_room }
    let(:teacher) { create :user, class_rooms: [class_room] }
    let(:lecture) { build :lecture, teacher: teacher, class_room: class_room }
    let(:json_payload) { %({"token": "#{teacher.token}", "classId": "#{class_room.id}", "name": "#{lecture.name}","startTime": "#{lecture.start_time.to_i}"}) }
    let(:pattern) do
      {
        id: :lecture_id,
        classId: class_room.id,
        name: lecture.name,
        teacherId: teacher.id,
        teacherName: teacher.name,
        channel: /^lecture_\d+$/,
        startTime: lecture.start_time.to_i
      }
    end

    it "should be successfully created by a teacher" do
     post create_lectures_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
     response.body.should match_json_expression pattern
    end

    it "should list out all the lectures of a teacher" do
      lecture.save
     post lectures_path(format: :json), %({"token": "#{teacher.token}"}), CONTENT_TYPE: 'application/json'
     response.body.should match_json_expression [pattern]
    end
  end
end
