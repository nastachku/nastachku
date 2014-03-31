#encoding: utf-8
class Web::WelcomeController < Web::ApplicationController
  caches_action :index, 
  
  def index
    @lectures = LectureDecorator.decorate_collection Lecture.scheduled.with_active_speaker.shuffle.first 4
  end

end
