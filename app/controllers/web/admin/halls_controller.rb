class Web::Admin::HallsController < Web::Admin::ApplicationController
  def index
    @halls = Hall.web
  end

  def new
    @hall = Hall.new
  end

  def edit
    @hall = Hall.find params[:id]
  end

  def create  
    @hall = Hall.new params[:hall]
    @hall.changed_by = current_user
    if @hall.save
      flash_success
      redirect_to admin_halls_path
    else
      flash_error
      render :new
    end
  end

  def update 
    @hall = Hall.find params[:id]
    @hall.changed_by = current_user
    if @hall.update_attributes params[:hall]
      flash_success
      redirect_to admin_halls_path
    else
      flash_error
      render :edit
    end
  end

  def destroy
    @hall = Hall.find params[:id]
    @hall.destroy
    redirect_to admin_halls_path
  end
end
