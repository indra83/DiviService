require 'spec_helper'

describe "Updates" do
  describe "POST /getContentUpdates" do
    let(:class_room)    { create :class_room }
    let(:course)        { create :course, class_rooms: [class_room] }
    let(:book)          { create :book, course: course }
    let(:updates)       { (1..3).map { |n| create :update, book: book, version: n } }

    let(:user)          { create :user, class_rooms: [class_room]}

    subject(:pattern) do
      {
        updates: [
          {
            courseId:     course.id.to_s,
            bookId:       book.id.to_s,
            version:      updates[2].version.to_s,
            description:  updates[2].description,
            details:      updates[2].details,
            webUrl:       updates[2].file
          }.ignore_extra_keys!
        ]
      }.ignore_extra_keys!
    end

    it "should return list of user's updates" do
      pattern
      post content_updates_path(format: :json), %({"token": "#{user.token}", "versions": []}), CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end

    it "should return only recent updates" do
      pattern
      post content_updates_path(format: :json), %({"token": "#{user.token}", "versions": [{ "bookId":"#{book.id}", "version":"2"}]}), CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression({
        updates: [
          {
            courseId:     course.id.to_s,
            bookId:       book.id.to_s,
            version:      updates[2].version.to_s,
            description:  updates[2].description,
            details:      updates[2].details,
            webUrl:         updates[2].file
          }.ignore_extra_keys!
        ]
      }.ignore_extra_keys!)
    end

    it "should return staging updates for teachers" do
      staging_update = create :update, book: book, version: 4, status: 'staging'
      user.update_attributes role: 'teacher'
      pattern = {
        updates: [
          {
            courseId:     course.id.to_s,
            bookId:       book.id.to_s,
            version:      staging_update.version.to_s,
            description:  staging_update.description,
            details:      staging_update.details,
            webUrl:       staging_update.file
          }.ignore_extra_keys!
        ]
      }.ignore_extra_keys!
      post content_updates_path(format: :json), %({"token": "#{user.token}", "versions": [{ "bookId":"#{book.id}", "version":"3"}]}), CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end

    it "should return staging updates for teachers" do
      staging_update = create :update, book: book, version: 4, status: 'staging'
      user.update_attributes role: 'student'
      post content_updates_path(format: :json), %({"token": "#{user.token}", "versions": [{ "bookId":"#{book.id}", "version":"3"}]}), CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression({ updates: [] }.ignore_extra_keys!)
    end
  end
end


