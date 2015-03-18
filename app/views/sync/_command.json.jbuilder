json.key_format! camelize: :lower

json.id            item.id.to_s
json.setid         item.setid.to_s
json.class_room_id item.class_room_id.to_s
json.student_id    item.student_id.to_s
json.teacher_id    item.teacher_id.to_s
json.course_id     item.course_id.to_s
json.book_id       item.book_id.to_s
json.item_code     item.item_code
json.item_category item.item_category
json.category      item.category
json.status        item.status
json.data          item.data.to_s
json.applied_at    item.applied_at.try(:to_millistr)
json.ends_at       item.ends_at.to_millistr
json.created_at    item.created_at.to_millistr
json.updated_at    item.updated_at.to_millistr
