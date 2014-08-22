json.key_format! camelize: :lower

json.members @members do |member|
  json.uid          member.id
  json.name         member.name
  json.role         member.role
  json.profile_pic  member.pic
  json.last_sync_times member.tablet.try(:timestamps)
end
