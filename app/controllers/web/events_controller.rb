class Web::EventsController < Web::ApplicationController
  def index
    @events = UserEvent.scheduled.with_active_speaker.by_listener_votes.ransack(params).result
    if params[:workshop_id_eq]
      @workshop = Workshop.find params[:workshop_id_eq]
      title @workshop
    end
  end
end
