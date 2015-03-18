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
            bookVersion:  updates[2].book_version,
            description:  updates[2].description,
            details:      updates[2].details,
            webUrl:       updates[2].file
          }
        ]
      }
    end

    it "should return list of user's updates" do
      pattern
      json_payload = {
        token: user.token,
        tablet: {
          content: {
            versions: []
          }
        }
      }
      post content_updates_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'
      expect(response.body).to match_json_expression pattern
    end

    it "should return only recent updates" do
      pattern
      json_payload = {
        token: user.token,
        tablet: {
          content: {
            versions: [
              {
                bookId: book.id,
                version: 2
              }
            ]
          }
        }
      }
      post content_updates_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'
      expect(response.body).to match_json_expression({
        updates: [
          {
            courseId:     course.id.to_s,
            bookId:       book.id.to_s,
            bookVersion:  updates[2].book_version,
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
            bookVersion:  staging_update.book_version,
            description:  staging_update.description,
            details:      staging_update.details,
            webUrl:       staging_update.file
          }
        ]
      }
      json_payload = {
        token: user.token,
        tablet: {
          content: {
            versions: [
              {
                bookId: book.id,
                version: 3
              }
            ]
          }
        }
      }

      post content_updates_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'
      expect(response.body).to match_json_expression pattern
    end

    it "should return staging updates for teachers" do
      staging_update = create :update, book: book, book_version: 4, status: 'staging'
      user.update_attributes role: 'student'
      json_payload = {
        token: user.token,
        tablet: {
          content: {
            versions: [
              {
                bookId: book.id,
                version: 3
              }
            ]
          }
        }
      }

      post content_updates_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'

      expect(response.body).to match_json_expression({ updates: [] })
    end

    context "with patches" do
      let(:updates) { (1..5).map { |n| create :update, book: book, book_version: n, strategy: :patch } }

      it "should return all recent patches" do
        updates #create
        json_payload = {
          token: user.token,
          tablet: {
            content: {
              versions: [
                {
                  bookId: book.id,
                  version: 2
                }
              ]
            }
          }
        }

        post content_updates_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'

        expect(response.body).to match_json_expression({
          updates: (3..5).map { |n|
            {
              bookVersion:  n
            }
          }
        })
      end

      it "should return updates only since recent rewrite" do
        updates[3].update_attributes! strategy: :replace #v4


        json_payload = {
          token: user.token,
          tablet: {
            content: {
              versions: [
                {
                  bookId: book.id,
                  version: 2
                }
              ]
            }
          }
        }

        post content_updates_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'

        expect(response.body).to match_json_expression({
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

    context "including cdns" do
      it "should return only the live cdns for the school" do
        dead_cdn = create :cdn, school: class_room.school, pinged_at: 1.hour.ago
        live_cdn = create :cdn, school: class_room.school, pinged_at: 5.minutes.ago

        pattern = { cdn: [live_cdn.base_url] }

        json_payload = {
          token: user.token,
          tablet: {
            content: {
              versions: []
            }
          }
        }

        post content_updates_path(format: :json), json_payload.to_json, CONTENT_TYPE: 'application/json'
        expect(response.body).to match_json_expression pattern
      end
    end
  end
end
