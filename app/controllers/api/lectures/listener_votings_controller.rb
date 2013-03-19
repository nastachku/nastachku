class Api::Lectures::ListenerVotingsController < Api::Lectures::ApplicationController
  def create
    unless resource_lecture.listener_votings.vote_by current_user
      head :unprocessable_entity
    end
  end
end
