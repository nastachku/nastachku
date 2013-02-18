module EventRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :new_and_in_voting, -> { where(state: [:new, :voted]) }
    scope :web, ->{by_created_at}
    scope :scheduled, -> { where(state: :in_schedule) }
    scope :voted, -> { where(state: :voted) }
    scope :by_votes, -> { asc_by_votings_count }
  end
end