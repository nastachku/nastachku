class Api::EventsController < Api::ApplicationController
  def index
    type = params[:type]
    @events = type.constantize.admin
  end

  def my_programm
    @events = current_user.lecture_votings
  end
end
