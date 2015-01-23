#encoding: utf-8
class Web::WelcomeController < Web::ApplicationController
  def index
    @lectures = LectureDecorator.decorate_collection Lecture.includes(:workshop, :user).scheduled.with_active_speaker.shuffle.first 30
  end

end
