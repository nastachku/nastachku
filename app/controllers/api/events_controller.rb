class Api::EventsController < Api::ApplicationController
  def vote
    @event = UserEvent.find params[:event_id]
    current_user.go_to_event(@event)
    @event.reload
  end
end