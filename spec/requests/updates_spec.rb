require 'spec_helper'

describe "Updates" do
  describe "POST /getContentUpdates" do
    let(:user)          { create :user }

    let(:class_room)    { create :class_room, user: user }

    let(:course)        { create :course, class_room: class_room }
    let(:book)          { create :book, course: course }
    let(:updates)       { create_list :update, 3, book: book }

    subject(:pattern) do
      {
        courses: [
          {
            id: course.id,
            name: course.name,
            books: [
              {
                id: book.id,
                name: book.name,
                updates: updates.map do |update|
                  {
                    version:      update.version.to_s,
                    description:  update.description,
                    details:      update.details,
                    file:         update.file
                  }
                end
              } # More books
            ]
          } # More courses
        ]
      }
    end

    it "should return a token for successful login" do
      pattern
      post content_updates_path(format: :json), %({"token": "#{user.token}"}), CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end
  end
end


