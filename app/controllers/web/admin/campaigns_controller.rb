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
      redirect_to admin_campaigns_path
    else
      render :new
    end
  end

  def destroy
    campaign = Campaign.find params[:id]
    campaign.destroy

    redirect_to admin_campaigns_path
  end
end
