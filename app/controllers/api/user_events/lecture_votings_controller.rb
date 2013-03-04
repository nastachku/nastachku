class Api::UserEvents::LectureVotingsController < Api::UserEvents::ApplicationController
  def create
    resource_user_event.lecture_votings.vote_by current_user
  end
end