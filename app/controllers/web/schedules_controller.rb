class Web::SchedulesController < Web::ApplicationController
  include Web::SchedulesHelper

  def show
    @halls = HallDecorator.decorate_collection Hall.includes(slots: [:event]).activated.by_position.uniq
    @first_hall = @halls.first
    @lectures_slots = Slot.with(event_type: "Lecture")
    @slots = Slot.all
    @workshops = Workshop.all
  end
end
