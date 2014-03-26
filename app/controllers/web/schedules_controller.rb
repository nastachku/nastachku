class Web::SchedulesController < Web::ApplicationController
  def show
    @halls = HallDecorator.decorate_collection Hall.includes(:slots).activated.by_position
    @first_hall = @halls.first
    @slots = Slot.all
    @workshops = Workshop.all
  end
end
