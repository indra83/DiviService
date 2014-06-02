class TabletsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def create
    @tablet = Tablet.where(device_id: tablet_params.delete(:device_id)).first_or_initialize
    @tablet.update_attributes(tablet_params.merge(user_id: current_user.id))
  end

private
  def tablet_params
    params.require :tablet
  end

end
