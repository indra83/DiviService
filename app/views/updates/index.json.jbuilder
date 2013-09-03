json.cdn @current_user.school.cdns.map(&:base_url)
json.updates @updates do |update|
  json.courseId     update.book.course_id.to_s
  json.bookId       update.book_id.to_s
  json.version      update.version
  json.description  update.description
  json.details      update.details
  json.strategy     update.strategy
  json.status       update.status
  json.fileName     "#{update.id}.zip"
  json.webUrl       update.file
end
