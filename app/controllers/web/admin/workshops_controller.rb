class Web::Admin::WorkshopsController < Web::Admin::ApplicationController
  
  def index
    @workshops = Workshop.all
  end

  def new
    @workshop = WorkshopEditType.new 
  end

  def create 
    @workshop = WorkshopEditType.new params[:workshop]
    if @workshop.save
      flash_success
      redirect_to admin_workshops_path
    else
      flash_error
      render :new
    end
  end

  def edit
    @workshop = WorkshopEditType.find params[:id]
  end

  def update
    @workshop = WorkshopEditType.find params[:id]
    if @workshop.update_attributes params[:workshop]
      flash_success
      redirect_to admin_workshops_path
    else
      flash_error
      render :edit
    end    
  end

  def destroy
    @workshop = Workshop.find params[:id]
    @workshop.destroy
    redirect_to admin_workshops_path
  end

end
