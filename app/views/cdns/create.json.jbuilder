json.deviceId @cdn.id.to_s
json.updates @updates do |update|
	json.id update.id.to_s
	json.url update.file
end
