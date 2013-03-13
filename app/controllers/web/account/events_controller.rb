class Web::Account::EventsController < Web::Account::ApplicationController

  def new
    @user = UserEventEditType.find current_user
    @user.events.build
  end

  def create
    @user = UserEventEditType.find current_user
    @user.changed_by = current_user
    if @user.update_attributes params[:user]
      flash_success
      redirect_to root_path
    else
      flash_error
      render :new
    end
  end

  def update
    @event = current_user.events.find params[:id]
    @updated = @event.update_attributes params[:user_event]
    render :edit, layout: false
  end
end