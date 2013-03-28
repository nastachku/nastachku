class Web::SchedulesController < Web::ApplicationController
  def show
    @halls = Hall.web
    @workshops = Workshop.web
  end
end
