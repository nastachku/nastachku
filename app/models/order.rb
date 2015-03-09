class Order < ActiveRecord::Base
  attr_accessible :user_id, :items_count, :payment_state, :cost, :payment_system, :discount_id,
                  :transaction_id, :customer_info, :payment_state_event

  belongs_to :discount
  belongs_to :user
  has_many :tickets
  has_many :afterparty_tickets

  validates :items_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :web, -> { order(created_at: :desc) }
  scope :paid, -> { where(payment_state: :paid) }

  serialize :customer_info, Hash

  after_initialize :generate_number, if: :new_record?

  state_machine :payment_state, initial: :unpaid do
    state :unpaid
    state :paid
    state :canceled
    state :refunded
    state :declined

    after_transition any => :refunded, do: :cancel_tickets

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

  def recalculate_cost!
    total_cost = (tickets.pluck(:price) + afterparty_tickets.pluck(:price)).inject(:+)
    update_attributes cost: total_cost
  end

  def recalculate_items_count!
    total_items_count = tickets.count + afterparty_tickets.count
    update_attributes items_count: total_items_count
  end

  def cancel_tickets
    tickets.each(&:cancel)
    afterparty_tickets.each(&:cancel)
  end

  private

  def generate_number
    self.number = SecureRandom.uuid
  end
end
