json.array!(@lectures) do |lecture|
  json.extract! lecture, :teacher_id, :class_room_id, :name, :start_time
  json.url lecture_url(lecture, format: :json)
end
