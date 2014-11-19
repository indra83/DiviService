require 'rails_helper'

describe "ClassRooms" do
  describe "POST /createClassRoom" do
    before { create :school, id: 1 }
    let(:teacher) { create :user, role: :teacher }
    let(:student) { create :user, role: :student}
    let(:payload) {
      {
        token: teacher.token,
        standard: 'X',
        section: 'A'
      }
    }

    it "should create a new class room in the given school and return in response" do
      post create_class_room_path(format: :json), payload.to_json, CONTENT_TYPE: 'application/json'

      pattern = {
        classRooms: [
          {
            className: 'X',
            section: 'A'
          }.ignore_extra_keys!
        ].ignore_extra_values!
      }.ignore_extra_keys!
      response.body.should match_json_expression pattern
    end

    it "should not create a new class room for a student" do
      payload.merge! token: student.token
      post create_class_room_path(format: :json), payload.to_json, CONTENT_TYPE: 'application/json'

      response.body.should match_json_expression({error: {}.ignore_extra_keys!}.ignore_extra_keys!)
    end
  end

  describe "POST /joinClassRoom" do
    let(:user) { create :user }
    let(:class_room) { create :class_room }
    let(:payload) {
      {
        token: user.token,
        classId: class_room.id
      }
    }

    it "should add the class room to the list of user's class rooms" do
      post join_class_room_path(format: :json), payload.to_json, CONTENT_TYPE: 'application/json'

      pattern = {
        classRooms: [
          {
            classId: class_room.id.to_s
          }.ignore_extra_keys!
        ].ignore_extra_values!
      }.ignore_extra_keys!
      response.body.should match_json_expression pattern
    end

    it "should raise error when trying to add inexistent class room" do
      payload.merge! classId: 12345678

      post join_class_room_path(format: :json), payload.to_json, CONTENT_TYPE: 'application/json'

      response.body.should match_json_expression({error: {}.ignore_extra_keys!}.ignore_extra_keys!)
    end
  end

end
