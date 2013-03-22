module OrderRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, -> { by_created_at }
    scope :paid, -> { where(payment_state: :paid) }
  end

end