json.key_format! camelize: :lower

json.sync_items @sync_items, partial: 'sync_item', as: :item

json.students @students_points do |uid, items|
  json.uid uid.to_s
  json.sync_items items, partial: 'sync_item', as: :item
end

json.questions @questions_points do |question_id, items|
  json.question_id question_id.to_s
  json.sync_items items, partial: 'sync_item', as: :item
end
