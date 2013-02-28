class Web::UserEventsController < Web::ApplicationController

  before_filter :authenticate_user!, only: [ :vote ]

  def index
    @events = UserEvent.voted.by_votes
  end

  def vote
    event = UserEvent.find params[:user_event_id]
    current_user.vote(event)
    redirect_to :back
  end

end

