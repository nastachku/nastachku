class Web::LecturesController < Web::ApplicationController
  def index
    @lectures = Lecture.scheduled.with_active_speaker.by_listener_votes.ransack(params).result
    @workshops = Workshop.web
  end
end
