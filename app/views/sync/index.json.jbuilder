json.key_format! camelize: :lower

json.sync_items @items do |item|
  json.user_id         item.user_id.to_s
  json.book_id         item.book_id.to_s
  json.assessment_id   item.assessment_id.to_s
  json.question_id     item.question_id.to_s
  json.points          item.points.to_s
  json.attempts        item.attempts.to_s
  json.data            item.data
  json.last_updated_at item.last_updated_at.to_i.to_s
end
