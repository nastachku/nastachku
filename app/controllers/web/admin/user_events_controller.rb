class Web::Admin::UserEventsController < Web::Admin::ApplicationController
  def index
    @events = UserEvent.new_and_in_voting.web
  end

  def edit
    @event = ::Admin::UserEventEditType.find params[:id]
  end
  
  def update
    user_event = UserEvent.find params[:id]
    @event = user_event.becomes(::Admin::UserEventEditType)
    if @event.update_attributes params[:user_event]
      flash_success
      if @event.in_schedule?
        redirect_to edit_admin_event_cpath(@event)
      else
        redirect_to edit_admin_user_event_path(@event)
      end
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
