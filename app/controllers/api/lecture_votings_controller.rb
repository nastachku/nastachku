class Api::LectureVotingsController < Api::ApplicationController
  def create
    @event = UserEvent.find params[:event_id]
    @event.lecture_votings.vote_by current_user
  end
end