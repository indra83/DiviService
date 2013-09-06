require 'spec_helper'

describe "Instructions" do
  describe "POST /getInstructions" do
    let(:lecture) { create :lecture }
    let(:student) { create :user, class_rooms: [lecture.class_room] }
    let(:instructions) { create_list :instruction, 3, lecture: lecture }

    it "should return all the instructions" do
      json_payload = %({"token": "#{student.token}", "lectureId": "#{lecture.id}", "since": "0"})
      instructions # create instructions
      post instructions_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
      pattern = {
        lectureId: lecture.id,
        lectureStatus: lecture.status,
        instructions: instructions.map { |instruction|
          {
            id: instruction.id.to_s,
            timeStamp: instruction.created_at.to_i.to_s,
            data: instruction.payload
          }
        }
      }
      response.body.should match_json_expression pattern
    end
  end
end
