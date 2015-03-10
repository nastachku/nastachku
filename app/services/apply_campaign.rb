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
    @campaign ||= Campaign.where(
      tickets_count: [@tickets_count, nil],
      afterparty_tickets_count: [@afterparty_tickets_count, nil]
    ).where(":date BETWEEN campaigns.start_date AND campaigns.end_date", date: Time.current).first

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
