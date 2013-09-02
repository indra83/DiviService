class Instruction < ActiveRecord::Base
  belongs_to :lecture

	validates :payload, presence: true
	validates :lecture_id, presence: true

	after_create :publish

	delegate :channel, to: :lecture

	def publish
		PUBNUB.publish channel: channel, message: payload
	end
end
