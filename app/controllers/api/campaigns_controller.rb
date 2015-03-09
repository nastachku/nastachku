class Api::CampaignsController < Api::ApplicationController
  def discount
    campaign = ApplyCampaign.call params

    render json: { discount_percentage: campaign.discount_percentage }.to_json
  end
end
