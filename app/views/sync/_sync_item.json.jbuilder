json.key_format! camelize: :lower

json.user_id            item.user_id.to_s
json.book_id            item.book_id.to_s
json.assessment_id      item.assessment_id.to_s
json.question_id        item.question_id.to_s
json.total_points       item.total_points.to_s
json.attempts           item.attempts.to_s
json.correct_attempts   item.correct_attempts.to_s
json.wrong_attempts     item.wrong_attempts.to_s
json.subquestions       item.subquestions.to_s
json.data               item.data
json.last_updated_at    item.last_updated_at.to_i.to_s
