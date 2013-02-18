class Web::EventsController < Web::ApplicationController

  before_filter :authenticate_user!

  def new
    @user = UserEventEditType.find current_user.id
  end

  def vote
    event = UserEvent.find params[:event_id]
    current_user.vote(event)
    redirect_to :back
  end
  
  def create
    @user = UserEventEditType.find current_user.id
    if @user.update_attributes params[:user]
      flash_success
      redirect_to root_path
    else
      render :new
    end
  end
end

