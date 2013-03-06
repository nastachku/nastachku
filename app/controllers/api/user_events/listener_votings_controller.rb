class Api::UserEvents::ListenerVotingsController < Api::UserEvents::ApplicationController
  def create
    unless resource_user_event.listener_votings.vote_by current_user
      head :unprocessable_entity
    end
  end
end
