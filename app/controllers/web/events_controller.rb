class Web::EventsController < Web::ApplicationController

  before_filter :authenticate_user!

  def index
    @events = UserEvent.voted.by_created_at
  end

  def vote
    event = UserEvent.find params[:event_id]
    current_user.vote(event)
    redirect_to :back
  end

end

