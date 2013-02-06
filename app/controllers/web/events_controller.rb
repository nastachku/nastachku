class Web::EventsController < Web::ApplicationController
  
  def new
    @user = UserEventEditType.find params[:user_id]
  end
  
  def create
    @user = UserEventEditType.find params[:user_id]
    if @user.update_attributes params[:user]
      redirect_to root_path
    else
      render :new
    end
  end
end
