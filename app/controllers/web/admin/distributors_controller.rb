class Web::Admin::DistributorsController < Web::Admin::ApplicationController
  def index
    @distributors = Distributor.all
  end

  def new
    @distributor = ::Admin::DistributorEditType.new
  end

  def create
    @distributor = ::Admin::DistributorEditType.new params[:distributor]

    if @distributor.save
      redirect_to admin_distributors_path
    else
      render :new
    end
  end

  def edit
    @distributor = Distributor.find params[:id]
  end

  def update
    @distributor = ::Admin::DistributorEditType.find params[:id]

    if @distributor.update_attributes params[:distributor]
      redirect_to admin_distributors_path
    else
      render :edit
    end
  end

  def destroy
    @distributor = Distributor.find params[:id]
    @distributor.destroy
    redirect_to admin_distributors_path
  end
end
