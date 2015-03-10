class Api::CampaignsController < Api::ApplicationController
  def discount
    campaign = ApplyCampaign.call params

    render json: { discount_amount: campaign.discount_amount }.to_json
  end
end
