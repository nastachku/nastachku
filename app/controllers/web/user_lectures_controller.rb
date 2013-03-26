class Web::UserLecturesController < Web::ApplicationController

  def index
    @lectures = Lecture.voted.with_active_speaker.by_created_at.ransack(params).result
    @workshops = Workshop.web
  end

end
