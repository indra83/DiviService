json.key_format! camelize: :lower

json.uid         @current_user.id.to_s
json.token       @current_user.token
json.name        @current_user.name
json.profile_pic filepicker_image_url(@current_user.pic, User::PROFILE_PIC_OPTS)
json.role        @current_user.role
json.school_name @current_user.school_name
json.school_location @current_user.school.location
json.class_rooms @current_user.class_rooms do |class_room|
  json.class_id   class_room.id.to_s
  json.class_name class_room.standard
  json.section    class_room.section
  json.courses    class_room.courses do |course|
    json.id   course.id.to_s
    json.name course.name
  end
end
json.metadata   @current_user.metadata
