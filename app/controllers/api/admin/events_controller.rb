class Api::Admin::EventsController < Api::Admin::ApplicationController
  def index
    type = params[:type]
    @items = type.constantize.admin
  end
end