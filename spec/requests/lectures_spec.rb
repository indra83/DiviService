require 'rails_helper'

describe "Lecture" do
  let(:class_room) { create :class_room }
  let(:teacher) { create :user, role: 'teacher', class_rooms: [class_room] }
  let(:lecture) { build :lecture, teacher: teacher, class_room: class_room }
  let(:json_payload) { %({"token": "#{teacher.token}", "classRoomId": "#{class_room.id}", "name": "#{lecture.name}" }) }
  let(:pattern) do
    {
      id: :lecture_id,
      classRoomId: class_room.id.to_s,
      name: lecture.name,
      teacherId: teacher.id.to_s,
      teacherName: teacher.name,
      channel: /^lecture_\d+$/,
      startTime: /^\d{13}$/
    }
  end

  describe "POST /createLecture" do
    it "should be successfully created by a teacher" do
      post create_lectures_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
      expect(response.body).to match_json_expression pattern
    end

    it "should not allow teacher to create two live lectures simultaneously" do
      error_pattern = {
        error: {
          code: 422,
          errors: {
            teacher: :teacher_errors,
            class_room: :class_room_errors
          }
        }
      }

      lecture.save
      post create_lectures_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
      expect(response.body).to match_json_expression error_pattern
    end

  end

  describe "POST /getLectures" do
    it "should list out all the lectures of a teacher" do
      lecture.save
      post lectures_path(format: :json), %({"token": "#{teacher.token}"}), CONTENT_TYPE: 'application/json'
      expect(response.body).to match_json_expression [pattern]
    end
  end

  describe "POST /getLectureMembers" do
    it "should list all the members of the lecture to a teacher" do
      lecture.save
      students = create_list :user, 3, class_rooms: [class_room]
      pattern = { members: (students + [teacher]).map { |member|
        {
          uid:        member.id,
          name:       member.name,
          role:       member.role,
          profilePic: member.pic
        }
      } }
      post lecture_members_path(format: :json), %({"token": "#{teacher.token}", "lectureId": "#{lecture.id}"}), CONTENT_TYPE: 'application/json'
      expect(response.body).to match_json_expression pattern
    end
  end
end
