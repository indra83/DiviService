class TabletsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def create
    tablet = Tablet.where(device_id: tablet_params.delete(:device_id)).first_or_initialize
    status = tablet.persisted? ? 'updated' : 'created'
    tablet.update_attributes(tablet_params.merge(user_id: current_user.id))

    if tablet.errors.present?
      render json: {error: {code:422, message: "The tablet can not be #{status} due to validation errors", errors: tablet.errors} }
    else
      tablet.touch
      render json: { success: status }
    end
  end

private
  def tablet_params
    params.require(:tablet).permit!
  end

end
