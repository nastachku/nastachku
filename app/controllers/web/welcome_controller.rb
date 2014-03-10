#encoding: utf-8
class Web::WelcomeController < Web::ApplicationController
  def index
    @news = News.last(3)
    @lectures = LectureDecorator.decorate_collection Lecture.scheduled.with_active_speaker.shuffle.first 4
  end

end
