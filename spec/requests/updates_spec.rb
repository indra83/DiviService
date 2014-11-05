require 'rails_helper'

describe "Updates" do
  describe "POST /getContentUpdates" do
    let(:class_room)    { create :class_room }
    let(:course)        { create :course, class_rooms: [class_room] }
    let(:book)          { create :book, course: course }
    let(:updates)       { (1..3).map { |n| create :update, book: book, book_version: n } }

    let(:user)          { create :user, class_rooms: [class_room]}

    subject(:pattern) do
      {
        updates: [
          {
            courseId:     course.id.to_s,
            bookId:       book.id.to_s,
            bookVersion: updates[2].book_version,
            description:  updates[2].description,
            details:      updates[2].details,
            webUrl:       updates[2].file
          }
        ]
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
            courseId:     course.id.to_s,
            bookId:       book.id.to_s,
            bookVersion: updates[2].book_version,
            description:  updates[2].description,
            details:      updates[2].details,
            webUrl:       updates[2].file
          }
        ]
      })
    end

    it "should return staging updates for teachers" do
      staging_update = create :update, book: book, book_version: 4, status: 'staging'
      user.update_attributes role: 'teacher'
      pattern = {
        updates: [
          {
            courseId:     course.id.to_s,
            bookId:       book.id.to_s,
            bookVersion: staging_update.book_version,
            description:  staging_update.description,
            details:      staging_update.details,
            webUrl:       staging_update.file
          }
        ]
      }
      post content_updates_path(format: :json), %({"token": "#{user.token}", "versions": [{ "bookId":"#{book.id}", "version":"3"}]}), CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end

    it "should return staging updates for teachers" do
      staging_update = create :update, book: book, book_version: 4, status: 'staging'
      user.update_attributes role: 'student'
      post content_updates_path(format: :json), %({"token": "#{user.token}", "versions": [{ "bookId":"#{book.id}", "version":"3"}]}), CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression({ updates: [] })
    end

    context "with patches" do
      let(:updates) { (1..5).map { |n| create :update, book: book, book_version: n, strategy: :patch } }

      it "should return all recent patches" do
        updates #create
        post content_updates_path(format: :json), %({"token": "#{user.token}", "versions": [{ "bookId":"#{book.id}", "version":"2"}]}), CONTENT_TYPE: 'application/json'
        response.body.should match_json_expression({
          updates: (3..5).map { |n|
            {
              bookVersion:  n
            }
          }
        })
      end

      it "should return updates later only since recent rewrite" do
        updates[3].update_attributes! strategy: :replace #v4


        post content_updates_path(format: :json), %({"token": "#{user.token}", "versions": [{ "bookId":"#{book.id}", "version":"2"}]}), CONTENT_TYPE: 'application/json'
        response.body.should match_json_expression({
          updates: [
            {
              bookVersion:  5,
              strategy: 'patch'
            },
            {
              bookVersion:  4,
              strategy: 'replace'
            },

          ]
        })
      end

    end
  end
end


