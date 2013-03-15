class Web::EventsController < Web::ApplicationController
  def index
    @events = UserEvent.scheduled.with_active_speaker.by_listener_votes.ransack(params).result
    @workshops = Workshop.web
  end
end
