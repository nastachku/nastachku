class Web::EventsController < Web::ApplicationController
  def index
    if params[:q]
      @workshop = Workshop.find params[:q][:workshop_id_eq]
      @events = UserEvent.scheduled.with_active_speaker.by_votes.ransack(params[:q]).result
      title @workshop
    else
      @events = UserEvent.scheduled.with_active_speaker.by_votes
    end
  end
end
