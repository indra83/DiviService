json.uid @current_user.id.to_s
json.token @current_user.token
json.name @current_user.name
#json.profilePic "profile pic url"
json.role @current_user.role
json.schoolName @current_user.school_name
json.classRooms @current_user.class_rooms do |class_room|
  json.classId class_room.id.to_s
  json.className class_room.standard
  json.section class_room.section
  json.courses class_room.courses do |course|
    json.id course.id.to_s
    json.name course.name
  end
end
