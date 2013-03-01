class Api::UserEventsController < Api::ApplicationController
  def vote
    @event = UserEvent.find params[:user_event_id]
    current_user.vote(@event)
    @event.reload
  end
end
