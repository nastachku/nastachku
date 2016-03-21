class Web::SchedulesController < Web::ApplicationController
  include Web::SchedulesHelper

  def show
    @halls = HallDecorator.decorate_collection Hall.includes(slots: [:event]).activated.by_position.uniq
    gon.hall_count = @halls.count
    @first_hall = @halls.first
    @lectures_slots = Slot.with(event_type: "Lecture")
    @slots = Slot.all
    @workshops = Workshop.all

    @meta_tags = {
      title: "«Стачка 2016» — расписание докладов и мероприятий",
      description: "Программа докладов и других мероприятий международной IT-конференции «Стачка!» в Ульяновске.",
      keywords: "стачка программа"
    }
  end
end
