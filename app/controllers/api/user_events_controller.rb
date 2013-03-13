class Api::UserEventsController < Api::ApplicationController
  def update
    @event = UserEvent.find params[:id]
    if @event.update_attributes params[:user_event]
      flash_success
    else
      flash_error
    end
  end
end