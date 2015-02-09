class Order < ActiveRecord::Base
  include OrderRepository

  attr_accessible :user_id, :items_count, :payment_state, :cost, :payment_system, :discount_id

  validates :items_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :discount
  belongs_to :user

  after_initialize :generate_number, if: :new_record?

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
    # NOTE: здесь может не быть self? а у кого мы тогда вызываем метод, интересно?
    self && (self.unpaid? || self.declined?)
  end

  private
  def generate_number
    self.number = SecureRandom.uuid
  end

end
