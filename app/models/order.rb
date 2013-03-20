class Order < ActiveRecord::Base
  include OrderRepository

  attr_accessible :user_id, :items_count, :payment_state

  validates :user, presence: true
  validates :items_count, presence: true, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :user

  state_machine :payment_state, initial: :unpaid do
    state :unpaid
    state :paid
    state :canceled
    state :refunded
    state :declined

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
    self && (self.unpaid? || self.declined?)
  end

end
