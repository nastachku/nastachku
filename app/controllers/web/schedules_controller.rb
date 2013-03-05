class Web::SchedulesController < Web::ApplicationController
  def show
    @halls = Hall.web
  end
end
