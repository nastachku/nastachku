class Order < ActiveRecord::Base
  attr_accessible :user_id, :items_count, :payment_state, :cost, :payment_system, :discount_id,
                  :transaction_id, :customer_info, :payment_state_event, :from

  belongs_to :discount
  belongs_to :user
  belongs_to :coupon
  belongs_to :campaign
  has_many :tickets
  has_many :afterparty_tickets

  enum from: {
    buy_now: 1,
    account_order: 2
  }

  validates :items_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :web, -> { order(created_at: :desc) }
  scope :paid, -> { where(payment_state: :paid) }
  scope :except_unpaid, -> { where.not(payment_state: :unpaid) }

  serialize :customer_info, Hash

  after_initialize :generate_number, if: :new_record?

  state_machine :payment_state, initial: :unpaid do
    state :unpaid
    state :paid
    state :canceled
    state :refunded
    state :declined

    after_transition any => :refunded, do: :cancel_tickets
    after_transition any => :paid do |order, transition|
      if order.buy_now? || order.user.blank?
        GoogleAnalyticsClient.buy_now_event(order)
      else
        GoogleAnalyticsClient.buy_event(order)
      end
    end

    event :pay do
      transition [:unpaid, :declined] => :paid
    end

    event :cancel do
      transition [:unpaid] => :canceled
    end

    event :refund do
      transition [:paid] => :refunded
    end

    event :decline do
      transition [:unpaid] => :declined
    end
  end

  def unpaid_or_declined?
    unpaid? || declined?
  end

  def recalculate_cost
    total_cost = full_cost

    if total_cost > 0
      total_cost -= campaign_discount_value
      total_cost -= coupon_discount_value
    end

    total_cost = 0 if total_cost < 0
    self.cost = total_cost
  end

  def recalculate_cost!
    recalculate_cost
    save
  end

  def campaign_discount_value
    discount = if campaign.present?
      # скидка на все билеты
      if !campaign.tickets_count && !campaign.afterparty_tickets_count
        rate = afterparty_tickets.length + tickets.length
      # высчитываем, сколько комплектов попало в диапазон
      else
        rate_tickets = campaign.tickets_count ? tickets.length / campaign.tickets_count : nil
        rate_afterparty_tickets = campaign.afterparty_tickets_count ? afterparty_tickets.length / campaign.afterparty_tickets_count : nil
        rate = [rate_tickets, rate_afterparty_tickets].compact.min
      end
      campaign.discount_amount * rate
    else
      0
    end

    if discount > full_cost
      discount = 0
    end

    discount
  end

  def coupon_discount_value
    if coupon.present?
      with_campaign_discount = full_cost - campaign_discount_value
      with_campaign_discount - coupon.with_discount(with_campaign_discount)
    else
      0
    end
  end

  def partner_commission_value
    if coupon.present?
      with_campaign_discount = full_cost - campaign_discount_value
      coupon.partner_commission(with_campaign_discount)
    else
      0
    end
  end

  def recalculate_items_count!
    total_items_count = tickets.count + afterparty_tickets.count
    update_attributes items_count: total_items_count
  end

  def cancel_tickets
    tickets.each(&:cancel)
    afterparty_tickets.each(&:cancel)
  end

  def full_cost
    (tickets.map(&:price) + afterparty_tickets.map(&:price)).inject(:+) || 0
  end

  def has_discount?
    full_cost > cost
  end

  def has_active_campaign?
    campaign && campaign_discount_value > 0
  end

  def to_s
    id.to_s
  end

  private

  def generate_number
    self.number = SecureRandom.uuid
  end
end
