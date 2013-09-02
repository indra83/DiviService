json.deviceId @cdn.id
json.updates @updates do |update|
	json.id update.id
	json.url update.file
end
