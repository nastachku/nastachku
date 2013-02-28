class Web::Account::EventsController < Web::Account::ApplicationController

  def new
    @user = UserEventEditType.find current_user.id
    @user.events.build
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