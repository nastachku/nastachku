class Web::Admin::CampaignsController < Web::Admin::ApplicationController
  def index
    @campaigns = Campaign.order(start_date: :desc)
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new params[:campaign]

    if @campaign.save
      flash_success
      redirect_to admin_campaigns_path
    else
      flash_error
      render :new
    end
  end

  def edit
    @campaign = Campaign.find params[:id]
  end

  def update
    @campaign = Campaign.find params[:id]

    if @campaign.update_attributes(params[:campaign])
      flash_success
      redirect_to admin_campaigns_path
    else
      flash_error
      render :edit
    end
  end

  def destroy
    campaign = Campaign.find params[:id]
    campaign.destroy

    redirect_to admin_campaigns_path
  end
end
