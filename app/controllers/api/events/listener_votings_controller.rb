class Api::Events::ListenerVotingsController < Api::ApplicationController
  def create
    @event = UserEvent.find params[:event_id]
    @event.listener_votings.vote_by current_user
  end
end