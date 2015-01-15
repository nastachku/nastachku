# -*- coding: utf-8 -*-
class Web::UserLecturesController < Web::ApplicationController
  caches_action :index, unless: :current_user, :cache_path => Proc.new {|c|
    lecture = Lecture.voted.with_active_speaker.order('updated_at DESC').limit(1).first
    {:tag => "#{lecture.updated_at.to_i if lecture}_#{c.params.except(:_).to_s}"}
  }

  def index
    @lectures_with_lector = LectureDecorator.decorate_collection Lecture.includes(:workshop, :user).voted.with_active_speaker.by_created_at.ransack(params[:q]).result
    @lectures_without_lector = LectureDecorator.decorate_collection Lecture.includes(:workshop).voted.without_speaker.by_created_at.ransack(params[:q]).result
    @lectures = @lectures_with_lector + @lectures_without_lector
    @current_user_votings = LectureVoting.where(user_id: current_user.id) if current_user
    # вынести в show, если возможно, не забыть про хак в application.rb
    @lecture_id = params[:lecture_id]
    @lecture_by_id = LectureDecorator.decorate Lecture.find @lecture_id if @lecture_id
    #
    @workshops = Workshop.web
    gon.remote_filter_action = user_lectures_path
    respond_to do |format|
       format.html
       format.js
     end
  end

end
