require 'rails_helper'

describe 'Attempts' do
  describe 'POST /syncUp' do
    let(:user) { create :user }
    let(:book) { create :book }
    let(:attempts) { build_list :attempt, 3, user: user, book: book }
    let(:json_payload) { %({"token": "#{user.token}", "attempts": #{attempts.to_json} }) }

    it 'should create new sync items' do
      pattern = {
        last_sync_time: /^\d{13}$/,
        status: [ 'created' ] * 3
      }
      post sync_up_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end

    it 'should update existing sync items' do
      attempts.first.save
      pattern = {
        last_sync_time: /^\d{13}$/,
        status: [
          'updated',
          'created',
          'created'
        ]
      }
      post sync_up_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end
  end

  describe 'POST /syncDown' do
    let(:user) { create :user }
    let(:old_attempts)    { create_list :attempt, 2, user: user, updated_at: 2.hours.ago }
    let(:cut_off_attempt) { create :attempt, user: user, updated_at: 1.hour.ago }
    let(:new_attempts)    { create_list :attempt, 2, user: user, updated_at: Time.zone.now }

    let(:old_commands)    { create_list :command, 2, student: user, updated_at: 2.hours.ago }
    let(:cut_off_command) { create :command, student: user, updated_at: 1.hour.ago }
    let(:new_commands)    { create_list :command, 2, student: user, updated_at: Time.zone.now }

    let(:json_payload)    {
      {
        token: user.token,
        lastSyncTime: {
          attempts: cut_off_attempt.updated_at.to_millistr.to_s,
          commands: cut_off_command.updated_at.to_millistr.to_s
        }
      }
    }

    let(:expected_attempts) {[cut_off_attempt] + new_attempts}
    let(:expected_commands) {[cut_off_command] + new_commands}

    let(:pattern) do
      {
        attempts: expected_attempts.map { |item|
          {
            userId:           item.user_id.to_s,
            bookId:           item.book_id.to_s,
            courseId:         item.course_id.to_s,
            assessmentId:     item.assessment_id.to_s,
            questionId:       item.question_id.to_s,
            subquestions:     item.subquestions,
            totalPoints:      item.total_points.to_s,
            attempts:         item.attempts.to_s,
            correctAttempts:  item.correct_attempts,
            wrongAttempts:    item.wrong_attempts,
            data:             item.data,
            solvedAt:         item.solved_at.to_millistr,
            lastUpdatedAt:    item.last_updated_at.to_millistr
          }
        },
        commands: expected_commands.map { |command|
          {

          }
        },
        hasMoreData: false
      }
    end

    it "should return all new items" do
      pattern #initialize

      post sync_down_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end

    context "with pageination" do
      let(:json_payload) { super().merge itemsPerPage: 2 }
      let(:expected_attempts) { super()[0..1] }
      let(:expected_commands) { super()[0..1] }
      let(:pattern) { super().merge hasMoreData: true }

      it "should return first page of new items" do
        pattern #initialize

        post sync_down_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'
        response.body.should match_json_expression pattern
      end

      context "with no new commands" do
        let(:json_payload) {super().deep_merge lastSyncTime: {command: 1.minute.from_now}}
        let(:expected_commands) {[]}

        it "should return first page of new attempts with hasMoreData set" do
          pattern #initialize

          post sync_down_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'
          response.body.should match_json_expression pattern
        end

      end
    end
  end
end
