PUBNUB ||= Pubnub.new({
	publish_key: ENV['PUBNUB_PUBLISH_KEY'],
	subscribe_key: ENV['PUBNUB_SUBSCRIBE_KEY']
})
