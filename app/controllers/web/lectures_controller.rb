# -*- coding: utf-8 -*-
class Web::LecturesController < Web::ApplicationController
  def index
    @top_lectures = LectureDecorator.decorate_collection Lecture.where(move_to_top: true).web.by_listener_votes.ransack(params[:q]).result.limit(configus.move_to_top_count)
    @lectures_with_lector = LectureDecorator.decorate_collection Lecture.includes(:workshop, :user).web.with_active_speaker.where.not(id: @top_lectures.map(&:id)).by_listener_votes.ransack(params[:q]).result
    @lectures_without_lector = LectureDecorator.decorate_collection Lecture.includes(:workshop).web.without_speaker.where.not(id: @top_lectures.map(&:id)).by_listener_votes.ransack(params[:q]).result
    @lectures = @top_lectures + @lectures_with_lector + @lectures_without_lector
    @current_user_votings = LectureVoting.where(user_id: current_user.id) if current_user
    # вынести в show, если возможно, не забыть про хак в application.rb
    @lecture_id = params[:lecture_id]
    @lecture_by_id = LectureDecorator.decorate Lecture.find @lecture_id if @lecture_id
    #
    @workshops = Workshop.web

    @meta_tags = {
      title: "Полный список докладов IT-конференции «Стачка!»",
      description: "Перечень докладов международной IT-конференции «Стачка!» по всем категориям.",
      keywords: "список докладов стачка"
    }

    respond_to do |format|
       format.html
       format.js
    end
  end
end
