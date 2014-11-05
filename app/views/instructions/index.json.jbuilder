json.key_format! camelize: :lower

json.lecture_id     @lecture.id
json.lecture_status @lecture.status

json.instructions @instructions do |instruction|
  json.id         instruction.id.to_s
  json.data       instruction.payload.to_json.to_s
  json.time_stamp  instruction.created_at.to_millistr
end
