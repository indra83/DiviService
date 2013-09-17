require 'spec_helper'

describe "Lecture" do
  describe "POST /lectures" do
    let(:class_room) { create :class_room }
    let(:teacher) { create :user, role: 'teacher', class_rooms: [class_room] }
    let(:lecture) { build :lecture, teacher: teacher, class_room: class_room }
    let(:json_payload) { %({"token": "#{teacher.token}", "classId": "#{class_room.id}", "name": "#{lecture.name}","startTime": "#{lecture.start_time_stamp}"}) }
    let(:pattern) do
      {
        id: :lecture_id,
        classId: class_room.id.to_s,
        name: lecture.name,
        teacherId: teacher.id.to_s,
        teacherName: teacher.name,
        channel: /^lecture_\d+$/,
        startTime: /^\d{10}$/
      }.ignore_extra_keys!
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

    it "should list all the members of the lecture to a teacher" do
      lecture.save
      students = create_list :user, 3, class_rooms: [class_room]
      pattern = { members: (students + [teacher]).map { |member|
        {
          uid:  member.id,
          name: member.name,
          role: member.role
        }.ignore_extra_keys!
      } }
      post lecture_members_path(format: :json), %({"token": "#{teacher.token}", "lectureId": "#{lecture.id}"}), CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end
  end
end
