module UserRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, -> { by_email }

    scope :shown_as_participants, -> {
      where show_as_participant: true
    }

    scope :alphabetically, -> { order("first_name, last_name ASC") }
  end

end
