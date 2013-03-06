class Api::UserEvents::ApplicationController < Api::ApplicationController

  helper_method :resource_user_event

  def resource_user_event
    UserEvent.find params[:user_event_id]
  end
end