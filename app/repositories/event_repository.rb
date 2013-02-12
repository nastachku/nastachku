module EventRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, ->{by_created_at}
    scope :scheduled, -> { where(state: :in_schedule) }
    scope :voted, -> { where(state: :voted) }
  end
end