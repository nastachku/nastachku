require 'test_helper'

class ApplyCamplaignTest < ActiveSupport::TestCase
  def setup
    @order_hash = {tickets_count: 1, afterparty_tickets_count: 1}
    @order = create :order, :with_tickets
    @order.recalculate_cost!

    create :campaign
    create :campaign, tickets_count: nil, afterparty_tickets_count: nil
  end

  test 'returns correct campaign' do
    campaign = ApplyCampaign.call(@order_hash)

    assert { campaign.discount_percentage == 10 }
  end

  test 'links order to campaign' do
    campaign = ApplyCampaign.call(@order_hash.merge(id: @order.id))

    @order.reload

    assert { campaign.order == @order }
    assert { @order.cost == (@order.full_cost - @order.full_cost * campaign.discount_percentage / 100) }
  end

  test 'applies compaign if tickets_count is nil' do
    campaign = ApplyCampaign.call id: @order.id, tickets_count: 10

    @order.reload

    assert { campaign.order == @order }
    assert { @order.cost == (@order.full_cost - @order.full_cost * campaign.discount_percentage / 100) }
  end
end
