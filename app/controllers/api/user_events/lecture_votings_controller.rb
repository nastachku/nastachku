class Api::UserEvents::LectureVotingsController < Api::UserEvents::ApplicationController
  def create
    unless resource_user_event.lecture_votings.vote_by current_user
      head :unprocessable_entity
    end
  end
end