json.key_format! camelize: :lower

json.user_id            item.user_id.to_s
json.book_id            item.book_id.to_s
json.course_id          item.course_id.to_s
json.assessment_id      item.assessment_id.to_s
json.question_id        item.question_id.to_s
json.total_points       item.total_points
json.attempts           item.attempts
json.correct_attempts   item.correct_attempts
json.wrong_attempts     item.wrong_attempts
json.subquestions       item.subquestions
json.data               item.data
json.last_updated_at    item.last_updated_at.to_millistr
json.solved_at          item.solved_at.to_millistr
