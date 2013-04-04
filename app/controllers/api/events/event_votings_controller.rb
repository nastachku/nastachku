class Api::Events::EventVotingsController < Api::Events::ApplicationController
  def create
    unless resource_event.event_votings.vote_by current_user
      head :unprocessable_entity
    end
  end

  def destroy
    unless resource_event.event_votings.unvote_by current_user
      head :not_found
    end
  end
end