class Web::SchedulesController < Web::ApplicationController
  def show
    @halls = Hall.activated.by_position
    @workshops = Workshop.web
  end
end
