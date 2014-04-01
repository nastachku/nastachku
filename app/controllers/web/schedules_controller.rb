class Web::SchedulesController < Web::ApplicationController
  include Web::SchedulesHelper
  caches_action :show, unless: :signed_in?, cache_path: Proc.new {|c|
    hall = Hall.activated.order('updated_at DESC').limit(1).first
    {tag: "#{hall.updated_at.to_i if hall}"}
  }

  def show
    Rails.cache.fetch(schedule_cache_key) do
      @halls = HallDecorator.decorate_collection Hall.includes(slots: [:event]).activated.by_position.uniq
      @first_hall = @halls.first
      @lectures_slots = Slot.with(event_type: "Lecture")
      @slots = Slot.all
      @workshops = Workshop.all
    end
  end
end
