class Instruction < ActiveRecord::Base
  has_paper_trail

  belongs_to :lecture

	validates :payload, presence: true
	validates :lecture_id, presence: true

	after_create :publish

	delegate :channel, to: :lecture

	def publish
    dummy_callback = lambda { |message| logger.info "published message: #{message}" }
		PUBNUB.publish channel: channel, message: payload, callback: dummy_callback
	end
end
