#encoding: utf-8
class Web::WelcomeController < Web::ApplicationController
  caches_action :index, unless: :signed_in?, expires_in: 5.hours

  def index
    @lectures = Rails.cache.fetch 'welcome_lectures_array', expires_in: 5.hours do
      @lectures = LectureDecorator.decorate_collection Lecture.includes(:workshop, :user).scheduled.with_active_speaker.shuffle.first 30
    end
  end

end
