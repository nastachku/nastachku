class Web::SchedulesController < Web::ApplicationController
  def show
    @halls = Hall.activated.web
    @workshops = Workshop.web
  end
end
