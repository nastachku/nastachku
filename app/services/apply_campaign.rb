class ApplyCampaign
  attr_reader :order_hash

  def initialize(order_hash)
    @id = order_hash[:id]
    @tickets_count = order_hash[:tickets_count]
    @afterparty_tickets_count = order_hash[:afterparty_tickets_count]
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    link_campaign_to_order if order && suitable_campaign.persisted?

    suitable_campaign
  end

  def suitable_campaign
    @campaign = Campaign.suitable_for(@tickets_count, @afterparty_tickets_count, Time.current)

    @campaign || Campaign.new
  end

  private

  def link_campaign_to_order
    order.cost -= suitable_campaign.discount_amount
    order.campaign = suitable_campaign
    order.save
  end

  def order
    @order ||= Order.find_by id: @id
  end
end
