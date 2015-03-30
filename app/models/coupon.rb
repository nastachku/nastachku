class Coupon < ActiveRecord::Base
  validates :code, uniqueness: true, presence: true
  validates :partner, presence: true
  validates :discount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :commission, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :url, presence: true

  scope :active, -> { where(state: :active) }

  state_machine initial: :active do
    state :inactive
    state :active

    event :activate do
      transition inactive: :active
    end

    event :deactivate do
      transition active: :inactive
    end
  end

  def with_discount(sum)
    (sum * (100 - discount) / 100.0).ceil
  end

  def partner_commission(sum)
    (sum * commission / 100.0).ceil
  end
end
