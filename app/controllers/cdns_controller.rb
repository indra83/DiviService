class CdnsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @cdn = Cdn.where(id: params[:device_id]).first_or_initialize
		@cdn.school_id = params[:school_id] if params[:school_id]
		@cdn.base_url = params[:base_url] if params[:base_url]

    render json: {error: {code:422, message: "The cdn can not be saved due to validation errors", errors: @cdn.errors} }  unless @cdn.save

		@updates = @cdn.updates.uniq

  end
end
