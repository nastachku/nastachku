class Web::Admin::PropagatorsController < Web::Admin::ApplicationController
  def index
    @propagators = Propagator.all
  end

  def new
    @propagator = ::Admin::PropagatorEditType.new
  end

  def create
    @propagator = ::Admin::PropagatorEditType.new params[:propagator]

    if @propagator.save
      redirect_to admin_propagators_path
    else
      render :new
    end
  end

  def edit
    @propagator = Propagator.find params[:id]
  end

  def update
    @propagator = ::Admin::PropagatorEditType.find params[:id]

    if @propagator.update_attributes params[:propagator]
      redirect_to admin_propagators_path
    else
      render :edit
    end
  end

  def destroy
    @propagator = Propagator.find params[:id]
    @propagator.destroy
    redirect_to admin_propagators_path
  end
end
