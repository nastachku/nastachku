class Web::LecturesController < Web::ApplicationController
  caches_action :index, unless: :current_user, :cache_path => Proc.new {|c|
    lecture = Lecture.web.with_active_speaker.by_listener_votes.order('updated_at DESC').limit(1).first
    {:tag => "#{lecture.updated_at.to_i if lecture}_#{c.params.except(:_).to_s}"}
  }
  
  def index
    @lectures = LectureDecorator.decorate_collection Lecture.includes(:workshop, :lecture_votings).where(lecture_votings: {user_id: current_user}).web.with_active_speaker.by_listener_votes.ransack(params).result
    @lecture_id = params[:lecture_id]
    @lecture_by_id = LectureDecorator.decorate Lecture.find @lecture_id if @lecture_id
    @workshops = Workshop.web
    respond_to do |format|
       format.html
       format.js
    end
  end
end
