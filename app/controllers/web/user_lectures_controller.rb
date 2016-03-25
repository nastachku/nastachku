# -*- coding: utf-8 -*-
class Web::UserLecturesController < Web::ApplicationController
  def index
    @top_lectures = LectureDecorator.decorate_collection Lecture.includes(:workshop).where(move_to_top: true).voted.by_lecture_votes.by_created_at.ransack(params[:q]).result
    @lectures_with_lector = LectureDecorator.decorate_collection Lecture.includes(:workshop, :user).voted.with_active_speaker.where.not(id: @top_lectures.map(&:id)).by_lecture_votes.by_created_at.ransack(params[:q]).result
    @lectures_without_lector = LectureDecorator.decorate_collection Lecture.includes(:workshop).voted.without_speaker.where.not(id: @top_lectures.map(&:id)).by_lecture_votes.by_created_at.ransack(params[:q]).result
    @lectures = @top_lectures + @lectures_with_lector + @lectures_without_lector
    @current_user_votings = LectureVoting.where(user_id: current_user.id) if current_user
    # вынести в show, если возможно, не забыть про хак в application.rb
    @lecture_id = params[:lecture_id]
    @lecture_by_id = LectureDecorator.decorate Lecture.find @lecture_id if @lecture_id
    #
    @workshops = Workshop.web
    gon.remote_filter_action = user_lectures_path

    @meta_tags = {
      title: "«Стачка 2016» — доклады 2.0",
      description: "Перечень докладов, предложенных пользователями для IT-конференции «Стачка!» в Ульяновске.",
      keywords: "стачка доклады"
    }

    respond_to do |format|
       format.html
       format.js
    end
  end

end
