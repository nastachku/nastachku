class Web::SchedulesController < Web::ApplicationController
  caches_action :show, :cache_path => Proc.new {|c|
    hall = Hall.activated.order('updated_at DESC').limit(1).first
    curr_user = current_user ? current_user.id : "none"
    {:tag => "#{hall.updated_at.to_i if hall}_#{curr_user}"}
  }
  
  def show
    @halls = HallDecorator.decorate_collection Hall.joins(:slots).joins("LEFT OUTER JOIN lectures ON slots.event_id = lectures.id").where('lectures.id = slots.event_id').activated.by_position.uniq
    @first_hall = @halls.first
    @slots = Slot.all
    @workshops = Workshop.all
  end
end
