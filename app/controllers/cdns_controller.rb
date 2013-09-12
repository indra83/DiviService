class CdnsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @cdn = Cdn.where(id: params[:deviceId]).first_or_initialize
		@cdn.school_id = params[:schoolId] if params[:schoolId]
		@cdn.base_url = params[:baseUrl] if params[:baseUrl]

    render json: {error: {code:422, message: "The cdn can not be saved due to validation errors", errors: @cdn.errors} }  unless @cdn.save

		@updates = @cdn.updates

  end
end
