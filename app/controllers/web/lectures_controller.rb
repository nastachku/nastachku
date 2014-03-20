class Web::LecturesController < Web::ApplicationController
  def index
    @lectures = LectureDecorator.decorate_collection Lecture.web.with_active_speaker.by_listener_votes.ransack(params).result
    @lecture_id = params[:lecture_id]
    @lecture_by_id = LectureDecorator.decorate Lecture.find @lecture_id if @lecture_id
    @workshops = Workshop.web
    respond_to do |format|
       format.html
       format.js
    end
  end
end
