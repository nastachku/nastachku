class Web::Admin::UserEventsController < Web::Admin::ApplicationController
  def index
    @events = UserEvent.new_and_in_voting.web
  end

  def edit
    @event = UserEvent.find params[:id]
  end
  
  def update
    @event = UserEvent.find params[:id]
    if @event.update_attributes params[:user_event]
      flash_success
      redirect_to admin_user_events_path
    else
      flash_error
      render :edit
    end
  end
  
  def change_state
    @event = UserEvent.find params[:user_event_id]
    if @event
      @event.fire_state_event(params[:event])
      flash_success
    else
      flash_error
    end
    redirect_to admin_user_events_path
  end
end
