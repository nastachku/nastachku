class Web::UserLecturesController < Web::ApplicationController

  def index
    conditions = params || { s: "created_at desc" }
    @search = Lecture.ransack conditions
    @lectures = @search.result.voted.with_active_speaker.by_created_at

  end

end
