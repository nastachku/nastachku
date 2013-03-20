class Api::Lectures::LectureVotingsController < Api::Lectures::ApplicationController
  def create
    unless resource_lecture.lecture_votings.vote_by current_user
      head :unprocessable_entity
    end
  end
end