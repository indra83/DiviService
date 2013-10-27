require 'spec_helper'

describe 'SyncItems' do
  describe 'POST /sync_items' do
    let(:user) { create :user }
    let(:book) { create :book }
    let(:sync_items) { build_list :sync_item, 3, user: user, book: book }
    let(:json_payload) { %({"token": "#{user.token}", "sync_items": #{sync_items.to_json} }) }

    it 'should create new sync items' do
      pattern = {
        last_sync_time: /^\d{10}$/,
        status: [
          { 'success' => 'created' },
          { 'success' => 'created' },
          { 'success' => 'created' }
        ]
      }
      post sync_up_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end

    it 'should update existing sync items' do
      sync_items.first.save
      pattern = {
        last_sync_time: /^\d{10}$/,
        status: [
          { 'success' => 'updated'},
          { 'success' => 'created'},
          { 'success' => 'created'}
        ]
      }
      post sync_up_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end

  end
end
