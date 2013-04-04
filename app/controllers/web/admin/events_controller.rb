class Web::Admin::EventsController < Web::Admin::ApplicationController

  def index
    query = { s: 'created_at desc' }.merge(params[:q] || {})
    @search = Event.ransack(query)
    @events = @search.result.page(params[:page]).per(configus.pagination.admin_per_page)
  end

  def new 
    @event = ::Admin::EventEditType.new
  end

  def create
    @event = ::Admin::EventEditType.new params[:event]
    @event.event_votings_count = 0
    @event.changed_by = current_user
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
    @event.changed_by = current_user
    if @event.update_attributes params[:event]
      flash_success
      redirect_to edit_admin_event_path
    else
      flash_error
      render :edit
    end
  end

  def destroy
    @event = Event.find params[:id]
    @event.destroy
    redirect_to admin_events_path
  end
end
