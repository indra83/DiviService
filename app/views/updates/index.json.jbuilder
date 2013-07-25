json.courses @class_room.courses do |course|
  json.id course.id
  json.name course.name
  json.books course.books do |book|
    json.id book.id
    json.name book.name
    json.updates book.updates, :version, :description, :details, :file
  end
end
