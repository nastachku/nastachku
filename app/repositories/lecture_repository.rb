module LectureRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :new_and_in_voting, -> { where(state: [:new, :voted]) }
    scope :web, ->{ by_created_at.scheduled }
    scope :admin, ->{ by_created_at }
    scope :scheduled, -> { where(state: :in_schedule) }
    scope :without_votings_events, -> { where(state: [:in_schedule, :rejected]) }
    scope :voted, -> { where(state: :voted) }
    scope :by_lecture_votes, -> { by_lecture_votings_count }
    scope :by_listener_votes, -> { by_listener_votings_count }
    scope :with_active_speaker, -> { joins(:user).where(users: { state: :active}) }
  end
end