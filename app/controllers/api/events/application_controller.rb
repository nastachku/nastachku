class Api::Events::ApplicationController < Api::ApplicationController

  helper_method :resource_event

  def resource_event
    Event.find params[:event_id]
  end

end