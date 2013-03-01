class Web::UserEventsController < Web::ApplicationController

  def index
    @events = UserEvent.voted.with_active_speaker.by_votes
  end
end

