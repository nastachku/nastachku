class Order < ActiveRecord::Base
  attr_accessible :user_id, :items_count, :payment_state, :cost, :payment_system, :discount_id

  belongs_to :discount
  belongs_to :user

  validates :items_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :web, -> { order(created_at: :desc) }
  scope :paid, -> { where(payment_state: :paid) }

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
    unpaid? || declined?
  end

  private
  def generate_number
    self.number = SecureRandom.uuid
  end
end
