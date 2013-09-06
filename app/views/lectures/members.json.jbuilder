json.key_format! camelize: :lower

json.members @members do |member|
  json.uid          member.id
  json.name         member.name
  json.role         member.role
  json.profile_pic  filepicker_image_url(member.pic, User::PROFILE_PIC_OPTS)
end
