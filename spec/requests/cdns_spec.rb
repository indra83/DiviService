describe 'Cdns' do
  describe 'GET /getCacheUpdates' do
    let(:class_room) { create :class_room }
    let(:course) { create :course, class_rooms: [class_room] }
    let(:book) { create :book, course: course }
    let(:updates) { create_list :update, 3, book: book }
    let(:cdn) { create :cdn, school: class_room.school }

    it "should return all the updates" do
      json_payload = %({"deviceId": "#{cdn.id}"})
      pattern = {
        deviceId: cdn.id.to_s,
        updates: updates.map {|update| {
          id: update.id.to_s,
          url: update.file
        } }
      }
      post cache_updates_path(format: :json), json_payload, CONTENT_TYPE: 'application/json'
      response.body.should match_json_expression pattern
    end
  end
end

