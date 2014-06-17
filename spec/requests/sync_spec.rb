require 'spec_helper'

describe 'Attempts' do
  describe 'POST /syncUp' do
    let(:user) { create :user }
    let(:book) { create :book }
    let(:attempts) { build_list :attempt, 3, user: user, book: book }
    let(:json_payload) { %({"token": "#{user.token}", "attempts": #{attempts.to_json} }) }

    it 'should create new sync items' do
      pattern = {
        last_sync_time: /^\d{10}$/,
        status: [ 'created' ] * 3
      }
      post sync_up_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end

    it 'should update existing sync items' do
      attempts.first.save
      pattern = {
        last_sync_time: /^\d{10}$/,
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
    let(:attempts) { create_list :attempt, 3, user: user, updated_at: Time.now }
    let(:json_payload) { %({"token": "#{user.token}", "last_sync_time": "#{1.hour.ago.to_i}" }) }
    let(:pattern) do
      {
        syncItems: attempts.map do |item|
          {
            userId:         item.user_id.to_s,
            bookId:         item.book_id.to_s,
            assessmentId:   item.assessment_id.to_s,
            questionId:     item.question_id.to_s,
            totalPoints:   item.total_points.to_s,
            attempts:       item.attempts.to_s,
            data:           item.data,
            lastUpdatedAt: item.last_updated_at.to_i.to_s
          }.ignore_extra_keys!
        end
      }.ignore_extra_keys!
    end

    pending "should return all the items" do
      pattern #initialize

      post sync_down_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end

    pending "should not return old items" do
      pattern #initialize
      create_list :attempt, 2, user: user, updated_at: 2.hours.ago

      post sync_down_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end
  end
end
