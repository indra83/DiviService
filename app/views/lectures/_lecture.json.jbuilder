json.key_format! camelize: :lower

json.id lecture.id.to_s
json.class_room_id lecture.class_room_id.to_s
json.name lecture.name
json.teacher_id lecture.teacher_id.to_s
json.teacher_name lecture.teacher.name
json.channel lecture.channel
json.start_time lecture.start_time.to_millistr
json.status lecture.status
