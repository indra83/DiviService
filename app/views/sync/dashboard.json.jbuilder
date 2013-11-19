json.key_format! camelize: :lower

json.students @students_points do |student_item|
  json.uid student_item[0].to_s
  json.sync_items student_item[1], partial: 'sync_item', as: :item
end

json.questions @questions_points do |question_item|
  json.question_id question_item[0].to_s
  json.sync_items question_item[1], partial: 'sync_item', as: :item
end
