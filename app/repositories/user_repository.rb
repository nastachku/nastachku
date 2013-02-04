module UserRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, -> { by_created_at }

    scope :shown_as_participants, -> {
      where show_as_participant: true
    }
    scope :active, where(state: :active)
  end
end