class Web::Admin::EventsController < Web::Admin::ApplicationController

  def index
  	@events = BaseEvent.asc_by_start_time.asc_by_workshop_id
  end

  def new 
    @event = ::Admin::EventEditType.new
  end

  def create 
    @event = ::Admin::EventEditType.new params[:user_event]

    if @event.save
      flash_success
      redirect_to admin_events_path
    else
      flash_error
      render :new
    end
  end

  def edit
    @event = ::Admin::EventEditType.find params[:id]
  end

  def update
    @event = ::Admin::EventEditType.find params[:id]
    if @event.update_attributes params[:user_event]
      flash_success
      redirect_to admin_events_path
    else
      flash_error
      render :edit
    end
  end

  def destroy
    @event = BaseEvent.find params[:id]
    @event.delete
    redirect_to admin_events_path
  end
end
