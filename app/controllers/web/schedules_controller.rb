class Web::SchedulesController < Web::ApplicationController
  def show
    @halls = HallDecorator.decorate_collection Hall.activated.by_position
  end
end
