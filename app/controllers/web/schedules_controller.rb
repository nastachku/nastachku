class Web::SchedulesController < Web::ApplicationController
  caches_action :show, :cache_path => Proc.new {|c|
    hall = Hall.activated.order('updated_at DESC').limit(1).first
    {:tag => "#{hall.updated_at.to_i if hall}"}
  }
  
  def show
    @halls = HallDecorator.decorate_collection Hall.includes(:slots).activated.by_position
    @slots = Slot.all
    @workshops = Workshop.all
  end
end
