class Api::UserEventsController < Api::ApplicationController
  def vote
    @event = UserEvent.find params[:user_event_id]
    current_user.vote_to_event(@event)
    @event.reload
  end
end
