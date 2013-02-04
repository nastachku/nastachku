module UserRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, -> { by_email }

    scope :shown_as_participants, -> {
      where show_as_participant: true
    }
  end

end
