PUBNUB = Object.new.tap do |mock|
  def mock.publish(*args)
    Rails.logger.debug "published to pubnub with #{args}"
  end
end
