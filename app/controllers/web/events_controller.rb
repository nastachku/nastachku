class Web::EventsController < Web::ApplicationController
  def index
    @events = UserEvent.scheduled.with_active_speaker.by_listener_votes
    if params[:q]
      @events = @events.ransack(params[:q]).result
      @workshop = Workshop.find params[:q][:workshop_id_eq]
      title @workshop
    end
  end
end
