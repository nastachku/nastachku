class Web::UserLecturesController < Web::ApplicationController

  def index
    conditions = { s: 'created_at desc' }.merge(params || {})
    @search = Lecture.ransack conditions
    @lectures = LectureDecorator.decorate_collection @search.result.voted.with_active_speaker.by_created_at
    @workshops = Workshop.web
    gon.remote_filter_action = user_lectures_path
    respond_to do |format|
       format.html
       format.js
     end
  end

end
