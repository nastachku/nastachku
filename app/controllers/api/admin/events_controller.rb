class Api::Admin::EventsController < Api::Admin::ApplicationController
  def index
    type = params[:type]
    @items = type.scheduled.constantize.admin
  end
end