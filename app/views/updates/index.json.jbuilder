json.key_format! camelize: :lower

json.cdn @current_user.school.cdns.map(&:base_url)
json.updates @updates do |update|
  json.course_id     update.book.course_id.to_s
  json.book_id       update.book_id.to_s
  json.version      update.version
  json.description  update.description
  json.details      update.details
  json.strategy     update.strategy
  json.status       update.status
  json.file_name     "#{update.id}.zip"
  json.web_url       update.file
end
