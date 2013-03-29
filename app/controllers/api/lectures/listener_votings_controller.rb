class Api::Lectures::ListenerVotingsController < Api::Lectures::ApplicationController
  def create
    unless resource_lecture.listener_votings.vote_by current_user
      head :unprocessable_entity
    end
  end

  def destroy
    unless resource_lecture.listener_votings.unvote_by current_user
      head :not_found
    end
  end
end
