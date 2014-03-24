class Web::SchedulesController < Web::ApplicationController
  def show
    # @halls = HallDecorator.decorate_collection Hall.includes(slots: {lecture: :workshop}).activated.by_position
    @halls = HallDecorator.decorate_collection Hall.joins(:slots).joins("LEFT OUTER JOIN lectures ON slots.event_id = lectures.id").where('lectures.id = slots.event_id').activated.by_position.uniq
    @slots = Slot.all
    @workshops = Workshop.all
  end
end
