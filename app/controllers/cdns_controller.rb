class CdnsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @cdn = Cdn.where(id: params[:device_id]).first_or_initialize
		@cdn.base_url = params[:base_url] if params[:base_url]
    @cdn.pinged_at = DateTime.now
    @cdn.metadata = params.extract! :updates

    render json: {error: {code:422, message: "The cdn can not be saved due to validation errors", errors: @cdn.errors} }  unless @cdn.save

		@updates = @cdn.updates.uniq

  end
end
