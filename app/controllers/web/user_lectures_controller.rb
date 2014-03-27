class Web::UserLecturesController < Web::ApplicationController
  caches_action :index, unless: :current_user, :cache_path => Proc.new {|c|
    lecture = Lecture.voted.with_active_speaker.order('updated_at DESC').limit(1).first
    {:tag => "#{lecture.updated_at.to_i if lecture}_#{c.params.except(:_).to_s}"}
  }
  
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
