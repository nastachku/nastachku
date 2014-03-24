class Web::SchedulesController < Web::ApplicationController
  def show
    @halls = HallDecorator.decorate_collection Hall.includes(:slots).activated.by_position
    @slots = Slot.all
    @workshops = Workshop.all
  end
end
