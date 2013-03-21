class Api::EventsController < Api::ApplicationController
  def index
    type = params[:type]
    @events = type.constantize.web
  end
end