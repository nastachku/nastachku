class Web::LecturesController < Web::ApplicationController
  def index
    @lectures = LectureDecorator.decorate_collection Lecture.web.with_active_speaker.by_listener_votes.ransack(params).result
    @workshops = Workshop.web
    gon.remote_filter_action = lectures_path
    respond_to do |format|
       format.html
       format.js
     end
  end
end
