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
        updates: updates.map do |update|
          {
            courseId:     course.id,
            bookId:       book.id,
            version:      update.version.to_s,
            description:  update.description,
            details:      update.details,
            webUrl:     update.file
          }.ignore_extra_keys!
        end
      }
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
            courseId:     course.id,
            bookId:       book.id,
            version:      updates[2].version.to_s,
            description:  updates[2].description,
            details:      updates[2].details,
            webUrl:         updates[2].file
          }.ignore_extra_keys!
        ]
      })
    end
  end
end


