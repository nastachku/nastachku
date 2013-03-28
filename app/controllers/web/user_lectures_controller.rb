class Web::UserLecturesController < Web::ApplicationController

  def index
    conditions = { s: 'created_at desc' }.merge(params || {})
    @search = Lecture.ransack conditions
    @lectures = @search.result.voted.with_active_speaker.by_created_at
    @workshops = Workshop.web
  end

end
